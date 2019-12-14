import java.awt.BorderLayout;
import java.awt.CardLayout;
import java.awt.EventQueue;
import java.awt.FlowLayout;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import java.awt.Color;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class SlideShow extends JFrame {

	//Declare Variables
	private JPanel slidePane;
	private JPanel textPane;
	private JPanel buttonPane;
	private CardLayout card;
	private CardLayout cardText;
	private JButton btnPrev;
	private JButton btnNext;
	private JButton setBckgrd;
	private JLabel lblSlide;
	private JLabel lblTextArea;
	private List<String> images = new ArrayList<>();

	/**
	 * Create the application.
	 */
	public SlideShow() throws HeadlessException {
		initComponent();
	}

	/**
	 * Initialize the contents of the frame.
	 */
	private void initComponent() {
		//Initialize variables to empty objects
		card = new CardLayout();
		cardText = new CardLayout();
		slidePane = new JPanel();
		textPane = new JPanel();
		textPane.setBackground(Color.BLUE);
		textPane.setBounds(5, 470, 790, 50);
		textPane.setVisible(true);
		buttonPane = new JPanel();
		btnPrev = new JButton();
		btnNext = new JButton();
		lblSlide = new JLabel();
		lblTextArea = new JLabel();
		setBckgrd = new JButton();

		//Setup frame attributes
		setSize(800, 600);
		setLocationRelativeTo(null);
		setTitle("Top 5 Destinations SlideShow");
		getContentPane().setLayout(new BorderLayout(10, 50));
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

		//Setting the layouts for the panels
		slidePane.setLayout(card);
		textPane.setLayout(cardText);
		
		//logic to add each of the slides and text
		for (int i = 1; i <= 5; i++) {
			lblSlide = new JLabel();
			lblTextArea = new JLabel();
			lblSlide.setText(getResizeIcon(i));
			lblTextArea.setText(getTextDescription(i));
			slidePane.add(lblSlide, "card" + i);
			textPane.add(lblTextArea, "cardText" + i);
		}

		getContentPane().add(slidePane, BorderLayout.CENTER);
		getContentPane().add(textPane, BorderLayout.SOUTH);

		buttonPane.setLayout(new FlowLayout(FlowLayout.CENTER, 20, 10));

		btnPrev.setText("Previous");
		btnPrev.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				goPrevious();
			}
		});
		buttonPane.add(btnPrev);

		btnNext.setText("Next");
		btnNext.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				goNext();
			}
		});
		buttonPane.add(btnNext);

		setBckgrd.setText("Background Color"); // This is a button to chose a background color for the main page.
		setBckgrd.addActionListener(new ActionListener(){
			@Override
			public void actionPerformed(ActionEvent e) {
				chooseColor();
			}
		});
		buttonPane.add(setBckgrd);

		getContentPane().add(buttonPane, BorderLayout.SOUTH);
	}

	/**
	 * Previous Button Functionality
	 */
	private void goPrevious() {
		card.previous(slidePane);
		cardText.previous(textPane);
	}
	
	/**
	 * Next Button Functionality
	 */
	private void goNext() {
		card.next(slidePane);
		cardText.next(textPane);
	}

	/**
	 * Set background color Functionality
	 */
	private void chooseColor() {
		Color c = JColorChooser.showDialog(this,"Choose",Color.BLUE);
		textPane.setBackground(c);
	}

	/**
	 * Method of building an Array holding the picture files. 
	 */
	private String topFiveLocations() {

		File folder = new File("resources");
		File[] listofImages = folder.listFiles();

		// Ensure that naming of files is consistent with customer base templates. 
		// For example: TestImageN.jpg where 'N' is a number of the file. 

		for (int i = 0; i < listofImages.length; i++) {
			if (listofImages[i].isFile()){
				images.add(listofImages[i].getName().endsWith(".jpg"));
			}
		}

	}

	/**
	 * Method to get the images
	 */
	private String getResizeIcon(int i) {
		String image = "<html><body><img width= '800' height='500' src='/resources/%s'</body></html>"; 
		images.forEach(name -> {
			if (name.indexOf(String.valueOf(i)) != -1) {
				return String.format(image,name);
			}
		})
		// if (i==1){
		// 	image = "<html><body><img width= '800' height='500' src='" + getClass().getResource("/resources/TestImage1.jpg") + "'</body></html>";
		// } else if (i==2){
		// 	image = "<html><body><img width= '800' height='500' src='" + getClass().getResource("/resources/TestImage2.jpg") + "'</body></html>";
		// } else if (i==3){
		// 	image = "<html><body><img width= '800' height='500' src='" + getClass().getResource("/resources/TestImage3.jpg") + "'</body></html>";
		// } else if (i==4){
		// 	image = "<html><body><img width= '800' height='500' src='" + getClass().getResource("/resources/TestImage4.jpg") + "'</body></html>";
		// } else if (i==5){
		// 	image = "<html><body><img width= '800' height='500' src='" + getClass().getResource("/resources/TestImage5.jpg") + "'</body></html>";
		// }
		// return image;
	}
	
	/**
	 * Method to get the text values
	 */
	private String getTextDescription(int i) {
		String text = ""; 
		if (i==1){
			text = "<html><body><font size='5'>#1 The Grand Canyon.</font> <br>Spectacular canyon views and hiking.</body></html>";
		} else if (i==2){
			text = "<html><body>#2 Top Destination</body></html>";
		} else if (i==3){
			text = "<html><body>#3 Top Destination</body></html>";
		} else if (i==4){
			text = "<html><body>#4 Top Destination</body></html>";
		} else if (i==5){
			text = "<html><body>#5 Top Destination</body></html>";
		}
		return text;
	}
	
	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {

			@Override
			public void run() {
				SlideShow ss = new SlideShow();
				ss.setVisible(true);
			}
		});
	}
}