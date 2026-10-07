import 'package:flutter/material.dart';
import '../models/mythos_models.dart';
import '../theme/mythos_theme.dart';

class MythosData {
  static const List<MythStory> featuredStories = [
    MythStory(
      id: 'icarus',
      title: 'The Fall of Icarus',
      greekTitle: 'Ἴκαρος καὶ Δαίδαλος',
      subtitle: 'The Sun\'s Golden Embrace & The Wings of Hubris',
      epoch: 'Heroic Age • Crete',
      readMinutes: 6,
      audioMinutes: 5,
      narrator: 'Nikolaos of Rhodes',
      tags: ['Hubris', 'Aeronautics', 'Tragedy', 'Daedalus'],
      category: 'Heroic Quests',
      excerpt:
          'Daedalus warned his son: "Fly not too low lest the ocean damp clogs thy feathers, nor too high lest Apollo\'s chariot melt the wax."',
      fullText:
          'Imprisoned in the towering labyrinth of King Minos on the island of Crete, the master craftsman Daedalus understood that all avenues of escape by sea were barred by Minotaur guards and Minos\'s navy.\n\n'
          '"Minos controls the land and the waves," Daedalus murmured to his young son Icarus, "yet the skies remain open. There shall we forge our path."\n\n'
          'Using the plumage of eagles, linen cord, and molten beeswax from Cretan apiaries, Daedalus constructed two pairs of great wings modeled on the anatomy of birds of prey. As he strapped the harnesses upon Icarus\'s shoulders, tears streamed down the artisan\'s aged cheeks.\n\n'
          '"Keep the middle course, Icarus," he counseled solemnly. "If thou fliest too low, the salty spray shall weigh down thy pinions; if thou soarest too high, the fiery radiance of Helios shall dissolve the wax that binds them."\n\n'
          'They leaped from the cliff into the azure winds. A fisherman gazing up from his skiff and a shepherd resting upon his crook mistook them for gods traversing the mortal heavens. Yet intoxicating joy soon consumed young Icarus. Enraptured by the boundless ether and the shimmering heights, he ascended toward the chariot of the sun. The blazing heat softened the fragrant wax. Feather after feather drifted away into the void, until Icarus plunged like a falling meteor into the sapphire expanse of the Icarian Sea.',
      highlightColor: MythosColors.goldAmber,
      emblemKey: 'sun_wings',
      trialQuestion:
          'What did Daedalus counsel Icarus to avoid doing during their flight?',
      trialOptions: [
        'Flying through thunderstorms over Mount Olympus',
        'Soaring too high near the sun or too low near the sea',
        'Carrying heavy bronze armor over the Aegean',
        'Singing hymns that could provoke the Harpies',
      ],
      correctOptionIndex: 1,
    ),
    MythStory(
      id: 'prometheus',
      title: 'The Gift of Prometheus',
      greekTitle: 'Προμηθεὺς Δεσμώτης',
      subtitle: 'The Titan\'s Defiance & The First Embers of Civilization',
      epoch: 'Titanomachy • Mount Olympus',
      readMinutes: 8,
      audioMinutes: 7,
      narrator: 'Helena Cassander',
      tags: ['Titans', 'Sacred Fire', 'Zeus', 'Mankind'],
      category: 'Creation Myths',
      excerpt:
          'Within the hollow stalk of a giant fennel, Prometheus smuggled the immortal spark from the hearth of Hephaestus down to shivering mortals.',
      fullText:
          'In the dawn of time, when mortals shivered in caves like defenseless beasts, Prometheus—whose very name meant Foresight—looked down with profound compassion upon humanity.\n\n'
          'Zeus had decreed that humankind must remain ignorant, fearing that gifted mortals might challenge the dominion of Olympus. But Prometheus climbed the holy summit under the cloak of night. Reaching the celestial forge of Hephaestus, he captured a seed of divine fire inside the pith of a green fennel stalk.\n\n'
          'Bringing it to Earth, he taught mortals not merely how to warm their shivering limbs, but how to smelt bronze, fashion agriculture, chart celestial constellations, and preserve songs in script. Through fire, humanity was granted the intellect of civilization.\n\n'
          'When Zeus observed smoke rising from mortal altars and iron gleaming in their hands, Olympian fury shook the cosmos. He ordered Prometheus bound with adamantine chains to the jagged peak of Mount Caucasus, where the eagle of Zeus would visit him at dawn—a testament to eternal sacrifice for mankind\'s ascension.',
      highlightColor: MythosColors.terracotta,
      emblemKey: 'flame',
      trialQuestion:
          'In what object did Prometheus conceal the sacred fire stolen from Olympus?',
      trialOptions: [
        'An amphora sealed with golden wax',
        'The hollow stalk of a giant fennel plant',
        'Inside the aegis shield of Athena',
        'Within an ivory horn of plenty',
      ],
      correctOptionIndex: 1,
    ),
    MythStory(
      id: 'orpheus',
      title: 'The Melodies of Orpheus',
      greekTitle: 'Ὀρφεύς καὶ Εὐρυδίκη',
      subtitle: 'The Lyre That Silenced the Underworld & The Fatal Backward Gaze',
      epoch: 'Classical Epoch • Thrace & Hades',
      readMinutes: 7,
      audioMinutes: 6,
      narrator: 'Orion Valerius',
      tags: ['Music', 'Underworld', 'Persephone', 'Love'],
      category: 'Underworld',
      excerpt:
          'His strings made the stone-faced Furies weep and brought the wheel of Ixion to a peaceful standstill, but the shadow was too quiet.',
      fullText:
          'Orpheus of Thrace held a gift bestowed directly by Apollo and Calliope: when his fingers caressed the golden strings of his tortoise-shell lyre, ferocious beasts knelt in reverent silence, and rivers halted their rush to listen.\n\n'
          'When his beloved bride Eurydice stepped upon a venomous viper and crossed into the gloomy banks of the River Styx, Orpheus refused to accept the finality of Thanatos. Armed only with his melody, he descended into the cavern of Cape Taenarum, down into the dread court of Hades.\n\n'
          'Before the throne of black obsidian, Orpheus sang of longing, mortal frailty, and the fleeting blossom of youth. Even Persephone wept tears of pearls, and Cerberus rested his three ferocious muzzles on the marble floor. Hades granted the soul of Eurydice on a single immutable covenant: Orpheus must walk ahead and never gaze behind him until both had stepped into the bright rays of the sun.\n\n'
          'Ascending the shadowy chasm, hearing not the faintest footfall of his beloved, doubt consumed his beating heart. Inches from the sunlit meadow, he glanced back—and saw Eurydice slip back into the mist with a final whisper: "Farewell."',
      highlightColor: MythosColors.aegeanLight,
      emblemKey: 'lyre',
      trialQuestion:
          'What condition did Lord Hades impose upon Orpheus to reclaim Eurydice?',
      trialOptions: [
        'He must sacrifice his golden lyre to Persephone',
        'He must never look back at her until reaching the sunlight',
        'He must slay Cerberus at the gates of Tartarus',
        'He had to drink from the waters of the River Lethe',
      ],
      correctOptionIndex: 1,
    ),
    MythStory(
      id: 'perseus',
      title: 'Perseus and the Aegis Shield',
      greekTitle: 'Περσεὺς καὶ Μέδουσα',
      subtitle: 'The Mirror of Polished Bronze & The Gorgon\'s Gaze',
      epoch: 'Heroic Age • Seriphos',
      readMinutes: 6,
      audioMinutes: 5,
      narrator: 'Cassandra Dorian',
      tags: ['Athena', 'Gorgon', 'Monsters', 'Hero'],
      category: 'Heroic Quests',
      excerpt:
          'Never gazing directly upon the venomous serpents of Medusa, Perseus beheld her coiled reflection in the immaculate polished bronze.',
      fullText:
          'Charged with an impossible quest by King Polydectes, Perseus sought the head of Medusa, the only mortal Gorgon whose direct gaze instantly turned flesh into rigid stone.\n\n'
          'Knowing human eyes could not withstand her visage, Athena gifted Perseus a round shield of bronze polished until it shone like a flawless mirror. Hermes presented him with winged talaria to ride the gale, and the nymphs bestowed the Cap of Darkness and an adamantine sickle.\n\n'
          'Arriving at the desolate cavern where petrified warriors stood frozen in mid-strike, Perseus walked backward, observing only the reflection upon Athena\'s gleaming surface. With one decisive strike, he severed the Gorgon\'s head and took flight before her immortal sisters could avenge her.',
      highlightColor: MythosColors.laurelGlow,
      emblemKey: 'shield',
      trialQuestion:
          'How did Perseus gaze upon Medusa without being turned to stone?',
      trialOptions: [
        'By drinking an elixir brewed from Moly flowers',
        'By looking only at her reflection in Athena\'s bronze shield',
        'By wearing the magical blindfold of Themis',
        'By casting a blinding solar illusion with Apollo\'s bow',
      ],
      correctOptionIndex: 1,
    ),
    MythStory(
      id: 'trojan',
      title: 'The Wooden Horse of Troy',
      greekTitle: 'Δούρειος Ἵππος',
      subtitle: 'Odysseus\'s Stratagem & The Fall of the Unconquered Citadel',
      epoch: 'The Epic Cycle • Ilium',
      readMinutes: 9,
      audioMinutes: 8,
      narrator: 'Nikolaos of Rhodes',
      tags: ['Troy', 'Odysseus', 'Athena', 'Warfare'],
      category: 'The Trojan War',
      excerpt:
          '"Beware the Greeks bearing gifts," cried Laocoön, hurling his spear into the hollow fir flanks that echoed with the clink of bronze.',
      fullText:
          'For ten agonizing years, the high walls of Ilium built by Apollo and Poseidon held firm against the fury of Agamemnon\'s legions. Seeing that force alone could not shatter the gates of Priam, Odysseus conceived the supreme stratagem.\n\n'
          'Under the guidance of Athena, the architect Epeius constructed a colossal hollow equine statue of mountain fir. Within its dark belly hid fifty chosen warriors, including Odysseus, Menelaus, and Neoptolemus.\n\n'
          'The Greek fleet burned their camp and sailed out of sight behind the island of Tenedos. Rejoicing that the siege had ended, the Trojans hauled the votive offering inside their ramparts despite the prophetess Cassandra\'s unheeded warnings. When night shrouded the drunken city in sleep, Sinon ignited the signal torch, and the champions poured forth from the timber beast to unlock the gates to the returning army.',
      highlightColor: MythosColors.goldPrimary,
      emblemKey: 'temple',
      trialQuestion:
          'Which master strategist conceived the creation of the Trojan Horse?',
      trialOptions: [
        'Achilles, son of Peleus',
        'Odysseus, King of Ithaca',
        'Agamemnon, King of Mycenae',
        'Hector, prince of Troy',
      ],
      correctOptionIndex: 1,
    ),
  ];

  static const List<Deity> olympianDeities = [
    Deity(
      id: 'zeus',
      name: 'Zeus',
      greekName: 'Ζεύς',
      title: 'King of Gods & Lord of the Sky',
      domain: 'Thunder, Justice, Sky & Hospitality (Xenia)',
      sacredSymbol: 'Thunderbolt, Golden Eagle, Royal Scepter, Oak',
      romanName: 'Jupiter',
      quote:
          'The sky trembles when the Father of Gods and Men nods his immortal brow.',
      lore:
          'Ruler of Mount Olympus and supreme arbiter of divine justice. Son of Cronus and Rhea, Zeus led his siblings in the ten-year Titanomachy to topple the Titans and establish the Olympian order. Guardian of sworn oaths and sacred hospitality.',
      primaryColor: Color(0xFF1E293B),
      accentColor: MythosColors.goldPrimary,
      iconKey: 'lightning',
    ),
    Deity(
      id: 'athena',
      name: 'Athena',
      greekName: 'Ἀθηνᾶ',
      title: 'Goddess of Wisdom & Strategic Warfare',
      domain: 'Tactics, Craftsmanship, Philosophy & Statecraft',
      sacredSymbol: 'Little Owl, Olive Tree, Aegis Shield, Gorgon Crest',
      romanName: 'Minerva',
      quote:
          'Wisdom is a fortress that neither siege nor time can overthrow.',
      lore:
          'Sprung fully armored from the forehead of Zeus, Athena embodies the calm, strategic intellect of civilized conflict and civic law. Patron deity of Athens after granting the gift of the first olive tree to its citizens.',
      primaryColor: Color(0xFF142B24),
      accentColor: MythosColors.laurelGlow,
      iconKey: 'owl',
    ),
    Deity(
      id: 'poseidon',
      name: 'Poseidon',
      greekName: 'Ποσειδῶν',
      title: 'Earth-Shaker & Sovereign of the Deep',
      domain: 'Oceans, Earthquakes, Storms & Horses',
      sacredSymbol: 'Three-Pronged Trident, Hippocampus, Dolphin, Bull',
      romanName: 'Neptune',
      quote:
          'At my strike, the sea boils and the foundations of the continents tremble.',
      lore:
          'Brother of Zeus and Hades, Poseidon commands the tempestuous waters and subterranean tectonic forces. With his bronze-footed horses, he rides atop surging crests in a chariot of coral and gold.',
      primaryColor: Color(0xFF0F2642),
      accentColor: MythosColors.aegeanLight,
      iconKey: 'trident',
    ),
    Deity(
      id: 'apollo',
      name: 'Apollo',
      greekName: 'Ἀπόλλων',
      title: 'Phoebus Apollo, God of Light & Prophecy',
      domain: 'Sun, Music, Poetry, Archery, Healing & Truth',
      sacredSymbol: 'Golden Lyre, Laurel Wreath, Silver Bow, Raven, Python',
      romanName: 'Apollo',
      quote:
          'The melody of truth heals the spirit even as it pierces the deceitful.',
      lore:
          'Twin brother of Artemis, Apollo personifies radiant youth, artistic balance, and divine illumination. Through the Pythia at Delphi, mortals traveled from across the Mediterranean to seek his oracular guidance.',
      primaryColor: Color(0xFF332008),
      accentColor: MythosColors.goldLight,
      iconKey: 'lyre',
    ),
    Deity(
      id: 'artemis',
      name: 'Artemis',
      greekName: 'Ἄρτεμις',
      title: 'Mistress of the Hunt & Queen of the Moon',
      domain: 'Wild Nature, Archery, Moon, Wilderness & Childbirth',
      sacredSymbol: 'Golden Stag, Crescent Moon, Silver Hunting Bow, Cypress',
      romanName: 'Diana',
      quote:
          'The sacred groves belong to the silent hunt and the unpolluted night.',
      lore:
          'Protector of the wildlands, untamed animals, and maidens. Armed with a silver bow crafted by the Cyclopes, Artemis roams mountainous peaks accompanied by her hunting hounds and forest nymphs.',
      primaryColor: Color(0xFF1A1C2E),
      accentColor: Color(0xFFA5B4FC),
      iconKey: 'moon',
    ),
    Deity(
      id: 'hades',
      name: 'Hades',
      greekName: 'Ἅιδης',
      title: 'Lord of the Unseen Realm & Wealth',
      domain: 'Underworld, Precious Ores, Funerary Rites & Souls',
      sacredSymbol: 'Helm of Darkness (Invisibility), Cerberus, Key of Hades, Asphodel',
      romanName: 'Pluto / Dis',
      quote:
          'All mortals ultimately walk through my gates; time is my patient servant.',
      lore:
          'Eldest brother of Zeus and Poseidon, Hades received the unseen subterranean kingdom during the division of the cosmos. Known as the Hospitable One and the Giver of Wealth for the gold, silver, and jewels hidden within the Earth.',
      primaryColor: Color(0xFF1E152A),
      accentColor: Color(0xFFC084FC),
      iconKey: 'helm',
    ),
  ];

  static const DelphiWisdom dailyWisdom = DelphiWisdom(
    quote: 'Know thyself, and nothing in excess.',
    greekText: 'Γνῶθι σεαυτόν • Μηδὲν ἄγαν',
    attribution: 'The Seven Sages of Ancient Greece',
    temple: 'Pronaos of the Temple of Apollo • Delphi',
    contemplation:
        'To understand the gods and the cosmos, an aspirant must first confront the depths and boundaries of their own mortal soul.',
  );

  static const List<ArtifactRelic> mythicRelics = [
    ArtifactRelic(
      name: 'The Aegis of Athena',
      greekName: 'Αἰγίς',
      craftsmaster: 'Hephaestus at the Mount Etna Forge',
      bearer: 'Pallas Athena & Lord Zeus',
      powerDescription:
          'Rimmed with golden tassels and emblazoned with the Gorgoneion, it strikes terror into the hearts of mortals and gods.',
      mythicLore:
          'Forged of divine hide and bronze, shaking the Aegis unleashes thunderous squalls and unshakeable courage in righteous defenders.',
      iconKey: 'shield',
    ),
    ArtifactRelic(
      name: 'The Golden Fleece',
      greekName: 'Χρυσόμαλλον Δέρας',
      craftsmaster: 'Chrysomallos, winged ram of Hermes',
      bearer: 'Jason & The Argonauts',
      powerDescription:
          'Bringer of sovereign prosperity and divine favor to whatever land hosts its radiant wool.',
      mythicLore:
          'Hung upon an ancient oak in the sacred grove of Ares in Colchis, guarded day and night by an unsleeping dragon.',
      iconKey: 'ram',
    ),
  ];

  static const List<String> categories = [
    'All Epics',
    'Heroic Quests',
    'Creation Myths',
    'The Underworld',
    'The Trojan War',
    'Olympian Feuds',
  ];
}
