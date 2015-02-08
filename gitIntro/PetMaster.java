/**
 * Created by NewProgrammer on 3/28/15.
 */
public class PetMaster {

    public static void main(String[] args) {

        String petReaction;

        Pet myPet = new Pet();

        myPet.eat();

        petReaction = myPet.talk("Tweet!! Tweet!!");

        System.out.println(petReaction);

        myPet.sleep();
    }
}
