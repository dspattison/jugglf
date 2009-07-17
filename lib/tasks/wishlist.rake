namespace :juggernaut do
  def boss(zone, name)
    return if zone.nil? or name.nil? or name.empty?
    zone.children.create(:object => Boss.create(:name => name))
  end
  
  def item(boss, name, note = nil)
    return if boss.nil? or name.nil? or name.empty?
    boss.children.create(:object => Item.find_or_create_by_name(name), 
      :note => note)
  end
  
  desc "Populate wishlist data"
  task :wishlist => [:environment] do
    [Boss, LootTable, Zone].each(&:destroy_all)
    
    ['World Drop'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      boss_name = 'Bind on Equip'
      boss = boss(zone, boss_name)
      
      item(boss, 'Arcanic Tramplers')
      item(boss, 'Benefactor\'s Gauntlets')
      item(boss, 'Bindings of Yearning')
      item(boss, 'Boots of Impetuous Ideals')
      item(boss, 'Boots of Septic Wounds')
      item(boss, 'Gloves of Fast Reactions')
      item(boss, 'Gloves of Token Respect')
      item(boss, 'Inexorable Sabatons')
      item(boss, 'Iron-Spring Jumpers')
      item(boss, 'Mantle of the Eternal Sentinel')
      item(boss, 'Poignant Sabatons')
      item(boss, 'Slime Stream Bands')
      item(boss, 'Spaulders of Egotism')
      item(boss, 'Surge Needle Ring')
      item(boss, 'Torn Web Wrapping')
      item(boss, 'Zeliek\'s Gauntlets')
    end
    
    ['The Obsidian Sanctum (H)', 'The Eye of Eternity (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      boss_name = ( zone_name == 'The Obsidian Sanctum (H)' ) ? 'Sartharion' : 'Malygos'
      boss = boss(zone, boss_name)
      
      case boss_name
      when 'Sartharion'
        item(boss, "Belabored Legplates")
        item(boss, "Bountiful Gauntlets")
        item(boss, "Chestguard of Flagrant Prowess")
        item(boss, "Chestplate of the Great Aspects")
        item(boss, "Concealment Shoulderpads")
        item(boss, "Council Chamber Epaulets")
        item(boss, "Dragon Brood Legguards")
        item(boss, "Dragonstorm Breastplate")
        item(boss, "Fury of the Five Flights")
        item(boss, "Gauntlets of the Lost Conqueror")
        item(boss, "Gauntlets of the Lost Protector")
        item(boss, "Gauntlets of the Lost Vanquisher")
        item(boss, "Headpiece of Reconciliation")
        item(boss, "Hyaline Helm of the Sniper")
        item(boss, "Illustration of the Dragon Soul")
        item(boss, "Leggings of the Honored")
        item(boss, "Obsidian Greathelm")
        item(boss, "Pennant Cloak")
        item(boss, "Staff of Restraint")
        item(boss, "The Sanctum's Flowing Vestments")
        item(boss, "Unsullied Cuffs")
        item(boss, "Upstanding Spaulders")
      when 'Malygos'
        item(boss, "Blanketing Robes of Snow")
        item(boss, "Blue Aspect Helm")
        item(boss, "Boots of Healing Energies")
        item(boss, "Boots of the Renewed Flight")
        item(boss, "Chestguard of the Recluse")
        item(boss, "Elevated Lair Pauldrons")
        item(boss, "Footsteps of Malygos")
        item(boss, "Frosted Adroit Handguards")
        item(boss, "Hailstorm")
        item(boss, "Hood of Rationality")
        item(boss, "Ice Spire Scepter")
        item(boss, "Leash of Heedless Magic")
        item(boss, "Leggings of the Wanton Spellcaster")
        item(boss, "Legplates of Sovereignty")
        item(boss, "Living Ice Crystals")
        item(boss, "Mantle of Dissemination")
        item(boss, "Mark of Norgannon")
        item(boss, "Melancholy Sabatons")
        item(boss, "Spaulders of Catatonia")
        item(boss, "Tunic of the Artifact Guardian")
        item(boss, "Unravelling Strands of Sanity")
        item(boss, "Winter Spectacle Gloves")
      end
    end
    
    # Naxxramas ---------------------------------------------------------------
    ['Naxxramas (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      [ 'Trash', 'Anub\'Rekhan', 'Grand Widow Faerlina', 'Maexxna', 
        'Noth the Plaguebringer', 'Heigan the Unclean', 'Loatheb', 'Patchwerk',
        'Grobbulus', 'Thaddius', 'Instructor Razuvious', 'Gothik the Harvester', 
        'Four Horsemen', 'Sapphiron', 'Kel\'Thuzad' ].each do |boss_name|
          boss = boss(zone, boss_name)
          
          case boss_name
          when 'Trash'
            item(boss, "Boots of the Escaped Captive")
            item(boss, "Haunting Call")
            item(boss, "Inevitable Defeat")
            item(boss, "Ousted Bead Necklace")
            item(boss, "Shadow of the Ghoul")
            item(boss, "Shoulderguards of the Undaunted")
            item(boss, "Silent Crusader")
          when 'Anub\'Rekhan'
            item(boss, "Arachnoid Gold Band")
            item(boss, "Chains of Adoration")
            item(boss, "Corpse Scarab Handguards")
            item(boss, "Cryptfiend's Bite")
            item(boss, "Dawnwalkers")
            item(boss, "Gemmed Wand of the Nerubians")
            item(boss, "Leggings of Atrophy")
            item(boss, "Mantle of the Locusts")
            item(boss, "Pauldrons of Unnatural Death")
            item(boss, "Rescinding Grips")
            item(boss, "Ruthlessness")
            item(boss, "Sabatons of Sudden Reprisal")
            item(boss, "Sand-Worn Band")
            item(boss, "Sash of the Parlor")
            item(boss, "Shield of Assimilation")
            item(boss, "Strong-Handed Ring")
            item(boss, "Swarm Bindings")
            item(boss, "Thunderstorm Amulet")
          when 'Grand Widow Faerlina'
            item(boss, "Atonement Greaves")
            item(boss, "Belt of False Dignity")
            item(boss, "Bracers of the Tyrant")
            item(boss, "Callous-Hearted Gauntlets")
            item(boss, "Cult's Chestguard")
            item(boss, "Dislocating Handguards")
            item(boss, "Epaulets of the Grieving Servant")
            item(boss, "Faerlina's Madness")
            item(boss, "Fire-Scorched Greathelm")
            item(boss, "Fool's Trial")
            item(boss, "Heritage")
            item(boss, "Idol of Worship")
            item(boss, "Lost Jewel")
            item(boss, "Punctilious Bindings")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Seized Beauty")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Totem of Misery")
            item(boss, "Tunic of Prejudice")
            item(boss, "Widow's Fury")
          when 'Maexxna'
            item(boss, "Ablative Chitin Girdle")
            item(boss, "Aged Winter Cloak")
            item(boss, "Bindings of the Hapless Prey")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cowl of the Perished")
            item(boss, "Defender's Code")
            item(boss, "Digested Silken Robes")
            item(boss, "Distorted Limbs")
            item(boss, "Dying Curse")
            item(boss, "Forethought Talisman")
            item(boss, "Grim Toll")
            item(boss, "Helm of Diminished Pride")
            item(boss, "Infectious Skitterer Leggings")
            item(boss, "Mantle of Shattered Kinship")
            item(boss, "Matriarch's Spawn")
            item(boss, "Quivering Tunic")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Sinner's Bindings")
            item(boss, "The Jawbone")
            item(boss, "Undiminished Battleplate")
            item(boss, "Wraith Strike")
          when 'Noth the Plaguebringer'
            item(boss, "Accursed Spine")
            item(boss, "Angry Dread")
            item(boss, "Bands of Impurity")
            item(boss, "Belt of Potent Chanting")
            item(boss, "Crippled Treads")
            item(boss, "Fool's Trial")
            item(boss, "Gauntlets of the Disobedient")
            item(boss, "Gloves of the Fallen Wizard")
            item(boss, "Heritage")
            item(boss, "Legguards of the Undisturbed")
            item(boss, "Libram of Radiance")
            item(boss, "Lost Jewel")
            item(boss, "Robes of Mutation")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Shoulderguards of Opportunity")
            item(boss, "Spinning Fate")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thrusting Bands")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Tunic of Masked Suffering")
          when 'Heigan the Unclean'
            item(boss, "Bindings of the Decrepit")
            item(boss, "Breastplate of Tormented Rage")
            item(boss, "Chestguard of Bitter Charms")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cryptfiend's Bite")
            item(boss, "Defender's Code")
            item(boss, "Dying Curse")
            item(boss, "Eruption-Scared Boots")
            item(boss, "Forethought Talisman")
            item(boss, "Gloves of the Dancing Bear")
            item(boss, "Grim Toll")
            item(boss, "Heigan's Putrid Vestments")
            item(boss, "Helm of Pilgrimage")
            item(boss, "Leggings of Colossal Strides")
            item(boss, "Legguards of the Apostle")
            item(boss, "Serene Echoes")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Sigil of Awareness")
            item(boss, "Stalk-Skin Belt")
            item(boss, "The Undeath Carrier")
          when 'Loatheb'
            item(boss, "Cowl of Innocent Delight")
            item(boss, "Fading Glow")
            item(boss, "Footwraps of Vile Deceit")
            item(boss, "Girdle of Unity")
            item(boss, "Greaves of Turbulence")
            item(boss, "Grotesque Handgrips")
            item(boss, "Mantle of the Lost Conqueror")
            item(boss, "Mantle of the Lost Protector")
            item(boss, "Mantle of the Lost Vanquisher")
            item(boss, "The Hand of Nerub")
            item(boss, "The Impossible Dream")
            item(boss, "Vest of Vitality")
          when 'Patchwerk'
            item(boss, "Arrowsong")
            item(boss, "Belt of the Tortured")
            item(boss, "Boots of Persuasion")
            item(boss, "Crude Discolored Battlegrips")
            item(boss, "Fleshless Girdle")
            item(boss, "Fool's Trial")
            item(boss, "Girdle of the Gambit")
            item(boss, "Gloves of Calculated Risk")
            item(boss, "Heritage")
            item(boss, "Hero's Surrender")
            item(boss, "Libram of Tolerance")
            item(boss, "Lost Jewel")
            item(boss, "Ruthlessness")
            item(boss, "Sash of Solitude")
            item(boss, "Split Greathammer")
            item(boss, "Strong-Handed Ring")
            item(boss, "Thunderstorm Amulet")
            item(boss, "Totem of Hex")
            item(boss, "Waistguard of Divine Grace")
          when 'Grobbulus'
            item(boss, "Bracers of Liberation")
            item(boss, "Chestguard of the Exhausted")
            item(boss, "Cloak of Averted Crisis")
            item(boss, "Cloak of the Shadowed Sun")
            item(boss, "Cowl of Vanity")
            item(boss, "Defender's Code")
            item(boss, "Depraved Linked Belt")
            item(boss, "Desecrated Past")
            item(boss, "Dying Curse")
            item(boss, "Fallout Impervious Tunic")
            item(boss, "Girdle of Chivalry")
            item(boss, "Grim Toll")
            item(boss, "Mantle of the Corrupted")
            item(boss, "Mantle of the Fatigued Sage")
            item(boss, "Origin of Nightmares")
            item(boss, "Plague Igniter")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Spaulders of Incoherence")
            item(boss, "Surplus Limb")
            item(boss, "Sympathetic Amice")
            item(boss, "Tunic of Indulgence")
            item(boss, "Twilight Mist")
          when 'Gluth'
          when 'Thaddius'
            item(boss, "Cincture of Polarity")
            item(boss, "Cover of Silence")
            item(boss, "Faceguard of the Succumbed")
            item(boss, "Headpiece of Fungal Bloom")
            item(boss, "Legplates of the Lost Conqueror")
            item(boss, "Legplates of the Lost Protector")
            item(boss, "Legplates of the Lost Vanquisher")
            item(boss, "Pauldrons of the Abandoned")
            item(boss, "Riveted Abomination Leggings")
            item(boss, "Sabatons of Endurance")
            item(boss, "Spire of Sunset")
            item(boss, "Wraps of the Persecuted")
          when 'Instructor Razuvious'
            item(boss, "Bands of Mutual Respect")
            item(boss, "Bindings of the Expansive Mind")
            item(boss, "Boots of Forlorn Wishes")
            item(boss, "Bracers of the Unholy Knight")
            item(boss, "Chains of Adoration")
            item(boss, "Chestpiece of Suspicion")
            item(boss, "Esteemed Bindings")
            item(boss, "Faithful Steel Sabatons")
            item(boss, "Fool's Trial")
            item(boss, "Gauntlets of Guiding Touch")
            item(boss, "Girdle of Razuvious")
            item(boss, "Girdle of Recuperation")
            item(boss, "Heritage")
            item(boss, "Idol of the Shooting Star")
            item(boss, "Legplates of Double Strikes")
            item(boss, "Ruthlessness")
            item(boss, "Sand-Worn Band")
            item(boss, "Shoulderpads of Secret Arts")
            item(boss, "Strong-Handed Ring")
            item(boss, "Totem of Dueling")
          when 'Gothik the Harvester'
            item(boss, "Abetment Bracers")
            item(boss, "Aged Winter Cloak")
            item(boss, "Bracers of Unrelenting Attack")
            item(boss, "Burdened Shoulderplates")
            item(boss, "Defender's Code")
            item(boss, "Dying Curse")
            item(boss, "Forethought Talisman")
            item(boss, "Gothik's Cowl")
            item(boss, "Grim Toll")
            item(boss, "Helm of Unleashed Energy")
            item(boss, "Helm of Vital Protection")
            item(boss, "Hood of the Exodus")
            item(boss, "Idol of Awakening")
            item(boss, "Leggings of Failed Escape")
            item(boss, "Leggings of Fleeting Moments")
            item(boss, "Libram of Resurgence")
            item(boss, "Life and Death")
            item(boss, "Shackled Cinch")
            item(boss, "Shawl of the Old Maid")
            item(boss, "Shroud of Luminosity")
            item(boss, "Touch of Horror")
          when 'Four Horsemen'
            item(boss, "Armageddon")
            item(boss, "Breastplate of the Lost Conqueror")
            item(boss, "Breastplate of the Lost Protector")
            item(boss, "Breastplate of the Lost Vanquisher")
            item(boss, "Broken Promise")
            item(boss, "Damnation")
            item(boss, "Final Voyage")
            item(boss, "Gloves of Peaceful Death")
            item(boss, "Helm of the Grave")
            item(boss, "Leggings of Voracious Shadows")
            item(boss, "Urn of Lost Memories")
          when 'Sapphiron'
            item(boss, "Bandit's Insignia")
            item(boss, "Bone-Inlaid Legguards")
            item(boss, "Boots of the Great Construct")
            item(boss, "Breastplate of Frozen Pain")
            item(boss, "Ceaseless Pity")
            item(boss, "Cosmic Lights")
            item(boss, "Extract of Necromantic Power")
            item(boss, "Gatekeeper")
            item(boss, "Gloves of Grandeur")
            item(boss, "Heroic Key to the Focusing Iris")
            item(boss, "Icy Blast Amulet")
            item(boss, "Legguards of the Boneyard")
            item(boss, "Legwraps of the Defeated Dragon")
            item(boss, "Murder")
            item(boss, "Noble Birthright Pauldrons")
            item(boss, "Platehelm of the Great Wyrm")
            item(boss, "Ring of Decaying Beauty")
            item(boss, "Rune of Repulsion")
            item(boss, "Soul of the Dead")
            item(boss, "Sympathy")
          when 'Kel\'Thuzad'
            item(boss, "Betrayer of Humanity")
            item(boss, "Boundless Ambition")
            item(boss, "Calamity's Grasp")
            item(boss, "Cape of the Unworthy Wizard")
            item(boss, "Crown of the Lost Conqueror")
            item(boss, "Crown of the Lost Protector")
            item(boss, "Crown of the Lost Vanquisher")
            item(boss, "Drape of the Deadly Foe")
            item(boss, "Envoy of Mortality")
            item(boss, "Journey's End")
            item(boss, "Last Laugh")
            item(boss, "Leggings of Mortal Arrogance")
            item(boss, "Signet of Manifested Pain")
            item(boss, "Sinister Revenge")
            item(boss, "The Turning Tide")
            item(boss, "Torch of Holy Fire")
            item(boss, "Voice of Reason")
            item(boss, "Wall of Terror")
          end
        end
    end
  
    ulduar_bosses = ['Bind on Equip', 
      'Flame Leviathan','Ignis the Furnacemaster','Razorscale','XT-002 Deconstructor', 
      'Kologarn','Auriaya','Assembly of Iron',
      'Hodir','Thorim','Freya','Mimiron',
      'General Vezax', 'Yogg-Saron', 'Algalon the Observer']
    
    ['Ulduar'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      ulduar_bosses.each do |boss_name|
        boss = boss(zone, boss_name)
        
        case boss_name
        when 'Bind on Equip'
        when 'Flame Leviathan'
          item(boss, "Combustion Bracers")
          item(boss, "Energy Siphon")
          item(boss, "Firesoul")
          item(boss, "Firestrider Chestguard")
          item(boss, "Flamewatch Armguards")
          item(boss, "Gilded Steel Legplates")
          item(boss, "Handguards of Potent Cures")
          item(boss, "Ironsoul")
          item(boss, "Kinetic Ripper")
          item(boss, "Lifespark Visage")
          item(boss, "Mantle of Fiery Vengeance")
          item(boss, "Might of the Leviathan")
          item(boss, "Pyrite Infuser")
          item(boss, "Shimmering Seal")
          item(boss, "Twirling Blades")
        when 'Ignis the Furnacemaster'
          item(boss, "Armbraces of the Vibrant Flame")
          item(boss, "Drape of Fuming Anger")
          item(boss, "Furnace Stone")
          item(boss, "Gauntlets of the Iron Furnace")
          item(boss, "Gloves of Smoldering Touch")
          item(boss, "Igniter Rod")
          item(boss, "Pauldrons of Tempered Will")
          item(boss, "Relentless Edge")
          item(boss, "Rifle of the Platinum Guard")
        when 'Razorscale'
          item(boss, "Band of Draconic Guile")
          item(boss, "Binding of the Dragon Matriarch")
          item(boss, "Bracers of the Smothering Inferno")
          item(boss, "Breastplate of the Afterlife")
          item(boss, "Dragonsteel Faceplate")
          item(boss, "Eye of the Broodmother")
          item(boss, "Ironscale Leggings")
          item(boss, "Razorscale Talon")
          item(boss, "Stormtempered Girdle")
          item(boss, "Treads of the Invader")
        when 'XT-002 Deconstructor'
          item(boss, "Aesir's Edge")
          item(boss, "Armbands of the Construct")
          item(boss, "Breastplate of the Stoneshaper")
          item(boss, "Chestplate of Vicious Potency")
          item(boss, "Conductive Cord")
          item(boss, "Fluxing Energy Coils")
          item(boss, "Gloves of Taut Grip")
          item(boss, "Helm of Veiled Energies")
          item(boss, "Magnetized Projectile Emitter")
          item(boss, "Plasma Foil")
          item(boss, "Power Enhancing Loop")
          item(boss, "Pulsing Spellshield")
          item(boss, "Treacherous Shoulderpads")
          item(boss, "Vest of the Glowing Crescent")
        when 'Kologarn'
          item(boss, "Emerald Signet Ring")
          item(boss, "Greaves of the Earthbinder")
          item(boss, "Mark of the Unyielding")
          item(boss, "Pendant of the Piercing Glare")
          item(boss, "Sabatons of the Iron Watcher")
          item(boss, "Shawl of the Shattered Giant")
          item(boss, "Shoulderguards of the Solemn Watch")
          item(boss, "Spark of Hope")
          item(boss, "Spire of Withering Dreams")
          item(boss, "Stoneguard")
        when 'Auriaya'
          item(boss, "Archaedas' Lost Legplates")
          item(boss, "Chestplate of Titanic Fury")
          item(boss, "Cover of the Keepers")
          item(boss, "Elemental Focus Stone")
          item(boss, "Ironaya's Discarded Mantle")
          item(boss, "Mantle of the Preserver")
          item(boss, "Nimble Climber's Belt")
          item(boss, "Nurturing Touch")
          item(boss, "Raiments of the Corrupted")
          item(boss, "Shieldwall of the Breaker")
        when 'Assembly of Iron'
          item(boss, "Belt of the Crystal Tree")
          item(boss, "Belt of the Iron Servant")
          item(boss, "Boots of the Petrified Forest")
          item(boss, "Circlet of True Sight")
          item(boss, "Cloak of the Iron Council")
          item(boss, "Greaves of Iron Intensity")
          item(boss, "Lady Maye's Sapphire Ring")
          item(boss, "Leggings of Swift Reflexes")
          item(boss, "Loop of the Agile")
          item(boss, "Perilous Bite")
          item(boss, "Rune-Etched Nightblade")
          item(boss, "Runetouch Handwraps")
          item(boss, "Stormtip")
          item(boss, "The Masticator")
          item(boss, "Watchful Eye")
        when 'Hodir'
          item(boss, "Avalanche")
          item(boss, "Bitter Cold Armguards")
          item(boss, "Cowl of Icy Breaths")
          item(boss, "Ice Layered Barrier")
          item(boss, "Icecore Staff")
          item(boss, "Leggings of the Wayward Conqueror")
          item(boss, "Leggings of the Wayward Protector")
          item(boss, "Leggings of the Wayward Vanquisher")
          item(boss, "Shiver")
          item(boss, "Signet of Winter")
          item(boss, "Stormedge")
          item(boss, "The Boreal Guard")
          item(boss, "Winter's Frigid Embrace")
        when 'Thorim'
          item(boss, "Belt of the Blood Pit")
          item(boss, "Combatant's Bootblade")
          item(boss, "Gauntlets of the Thunder God")
          item(boss, "Guise of the Midgard Serpent")
          item(boss, "Handwraps of Resonance")
          item(boss, "Hoperender")
          item(boss, "Legacy of Thunder")
          item(boss, "Leggings of Unstable Discharge")
          item(boss, "Mjolnir Runestone")
          item(boss, "Pendant of the Shallow Grave")
          item(boss, "Sif's Remembrance")
          item(boss, "Spaulders of the Wayward Conqueror")
          item(boss, "Spaulders of the Wayward Protector")
          item(boss, "Spaulders of the Wayward Vanquisher")
        when 'Freya'
          item(boss, "Chestguard of the Lasher")
          item(boss, "Fire Orchid Signet")
          item(boss, "Gloves of Whispering Winds")
          item(boss, "Gloves of the Wayward Conqueror")
          item(boss, "Gloves of the Wayward Protector")
          item(boss, "Gloves of the Wayward Vanquisher")
          item(boss, "Ironbark Faceguard")
          item(boss, "Legplates of Flourishing Resolve")
          item(boss, "Petrified Ivy Sprig")
          item(boss, "Seed of Budding Carnage")
          item(boss, "Serilas, Blood Blade of Invar One-Arm")
          item(boss, "Tunic of the Limber Stalker")
          item(boss, "Unraveling Reach")
        when 'Mimiron'
          item(boss, "Cable of the Metrognome")
          item(boss, "Fused Alloy Legplates")
          item(boss, "Fusion Blade")
          item(boss, "Greaves of the Iron Army")
          item(boss, "Helm of the Wayward Conqueror")
          item(boss, "Helm of the Wayward Protector")
          item(boss, "Helm of the Wayward Vanquisher")
          item(boss, "Mimiron's Flight Goggles")
          item(boss, "Pulse Baton")
          item(boss, "Shoulderguards of Assimilation")
          item(boss, "Static Charge Handwraps")
          item(boss, "Stylish Power Cape")
          item(boss, "Tempered Mercury Greaves")
        when 'General Vezax'
          item(boss, "Aesuga, Hand of the Ardent Champion")
          item(boss, "Bindings of the Depths")
          item(boss, "Boots of Unsettled Prey")
          item(boss, "Choker of the Abyss")
          item(boss, "Darkstone Ring")
          item(boss, "Drape of the Faceless General")
          item(boss, "Leggings of Profound Darkness")
          item(boss, "Pendant of Endless Despair")
          item(boss, "Saronite Animus Cloak")
          item(boss, "Shadowbite")
          item(boss, "Tortured Earth")
          item(boss, "Underworld Mantle")
          item(boss, "Vestments of the Piercing Light")
          item(boss, "Void Sabre")
        when 'Yogg-Saron'
          item(boss, "Abaddon")
          item(boss, "Amice of Inconceivable Horror")
          item(boss, "Caress of Insanity")
          item(boss, "Chestguard of the Wayward Conqueror")
          item(boss, "Chestguard of the Wayward Protector")
          item(boss, "Chestguard of the Wayward Vanquisher")
          item(boss, "Deliverance")
          item(boss, "Devotion")
          item(boss, "Faceguard of the Eyeless Horror")
          item(boss, "Hammer of Crushing Whispers")
          item(boss, "Kingsbane")
          item(boss, "Leggings of the Insatiable")
          item(boss, "Pendant of a Thousand Maws")
          item(boss, "Royal Seal of King Llane")
          item(boss, "Signet of Soft Lament")
          item(boss, "Soul-Devouring Cinch")
          item(boss, "Touch of Madness")
          item(boss, "Treads of the Dragon Council")
        when 'Algalon the Observer'
          item(boss, "Band of Lights")
          item(boss, "Breastplate of the Timeless")
          item(boss, "Dark Matter")
          item(boss, "Drape of the Messenger")
          item(boss, "Gloves of the Endless Dark")
          item(boss, "Meteorite Crystal")
          item(boss, "Nebula Band")
          item(boss, "Observer's Mantle")
          item(boss, "Pendant of the Somber Witness")
          item(boss, "Pulsar Gloves")
          item(boss, "Reply-Code Alpha")
          item(boss, "Shoulderplates of the Celestial Watch")
          item(boss, "Starfall Girdle")
          item(boss, "Starlight Treads")
          item(boss, "Strength of the Heavens")
          item(boss, "Zodiac Leggings")
        end
      end
    end
    
    ['Ulduar (H)'].each do |zone_name|
      zone = LootTable.create(:object => Zone.create(:name => zone_name))
      
      ulduar_bosses.each do |boss_name|
        boss = boss(zone, boss_name)
        
        case boss_name
        when 'Bind on Equip'
          item(boss, "Asimov's Drape", "Mimiron")
          item(boss, "Cowl of the Absolute", "Auriaya")
          item(boss, "Darkcore Leggings", "General Vezax")
          item(boss, "Iron Riveted War Helm", "Flame Leviathan")
          item(boss, "Leggings of Lost Love", "Thorim")
          item(boss, "Leggings of the Stoneweaver", "Kologarn")
          item(boss, "Lifeforge Breastplate", "Ignis the Furnacemaster")
          item(boss, "Northern Barrier", "Hodir")
          item(boss, "Nymph Heart Charm", "Freya")
          item(boss, "Phaelia's Vestments of the Sprouting Seed", "Assembly of Iron")
          item(boss, "Proto-hide Leggings", "Razorscale")
          item(boss, "Signet of the Earthshaker", "XT-002 Deconstructor")
        when 'Flame Leviathan'
          item(boss, "Boots of Fiery Resolution", "Hard Mode")
          item(boss, "Constructor's Handwraps")
          item(boss, "Embrace of the Leviathan")
          item(boss, "Freya's Choker of Warding")
          item(boss, "Gloves of the Fiery Behemoth")
          item(boss, "Glowing Ring of Reclamation")
          item(boss, "Golden Saronite Dragon", "Hard Mode")
          item(boss, "Mechanist's Bindings")
          item(boss, "Mimiron's Inferno Couplings")
          item(boss, "Overcharged Fuel Rod")
          item(boss, "Pendant of Fiery Havoc", "Hard Mode")
          item(boss, "Plated Leggings of Ruination", "Hard Mode")
          item(boss, "Shoulderpads of Dormant Energies", "Hard Mode")
          item(boss, "Steamcaller's Totem")
          item(boss, "Steamworker's Goggles")
          item(boss, "Strength of the Automaton")
          item(boss, "The Leviathan's Coil")
          item(boss, "Titanguard")
        when 'Ignis the Furnacemaster'
          item(boss, "Cindershard Ring")
          item(boss, "Flamestalker Boots")
          item(boss, "Flamewrought Cinch")
          item(boss, "Girdle of Embers")
          item(boss, "Heart of Iron")
          item(boss, "Helm of the Furnace Master")
          item(boss, "Intensity")
          item(boss, "Pyrelight Circle")
          item(boss, "Scepter of Creation")
          item(boss, "Soot-covered Mantle")
          item(boss, "Totem of the Dancing Flame")
          item(boss, "Worldcarver")
          item(boss, "Wristguards of the Firetender")
        when 'Razorscale'
          item(boss, "Belt of the Fallen Wyrm")
          item(boss, "Bracers of the Broodmother")
          item(boss, "Charred Saronite Greaves")
          item(boss, "Collar of the Wyrmhunter")
          item(boss, "Dragonslayer's Brace")
          item(boss, "Drape of the Drakerider")
          item(boss, "Guiding Star")
          item(boss, "Living Flame")
          item(boss, "Razorscale Shoulderguards")
          item(boss, "Remorse")
          item(boss, "Saronite Mesh Legguards")
          item(boss, "Shackles of the Odalisque")
          item(boss, "Sigil of Deflection")
          item(boss, "Veranus' Bane")
        when 'XT-002 Deconstructor'
          item(boss, "Boots of Hasty Revival")
          item(boss, "Brass-lined Boots")
          item(boss, "Breastplate of the Devoted", "Hard Mode")
          item(boss, "Charm of Meticulous Timing", "Hard Mode")
          item(boss, "Clockwork Legplates")
          item(boss, "Crazed Construct Ring")
          item(boss, "Gloves of the Steady Hand", "Hard Mode")
          item(boss, "Golem-Shard Sticker")
          item(boss, "Grasps of Reason", "Hard Mode")
          item(boss, "Horologist's Wristguards")
          item(boss, "Mantle of Wavering Calm")
          item(boss, "Quartz Crystal Wand")
          item(boss, "Quartz-studded Harness")
          item(boss, "Sandals of Rash Temperament")
          item(boss, "Shoulderplates of the Deconstructor")
          item(boss, "Sigil of the Vengeful Heart")
          item(boss, "Sorthalis, Hammer of the Watchers", "Hard Mode")
          item(boss, "Thunderfall Totem")
          item(boss, "Twisted Visage")
        when 'Kologarn'
          item(boss, "Bracers of Unleashed Magic")
          item(boss, "Decimator's Armguards")
          item(boss, "Giant's Bane")
          item(boss, "Gloves of the Pythonic Guardian")
          item(boss, "Handwraps of Plentiful Recovery")
          item(boss, "Idol of the Crying Wind")
          item(boss, "Ironmender")
          item(boss, "Malice")
          item(boss, "Necklace of Unerring Mettle")
          item(boss, "Robes of the Umbral Brute")
          item(boss, "Saronite Plated Legguards")
          item(boss, "Shoulderpads of the Monolith")
          item(boss, "Unfaltering Armguards")
          item(boss, "Wrathstone")
        when 'Auriaya'
          item(boss, "Amice of the Stoic Watch")
          item(boss, "Cloak of the Makers")
          item(boss, "Gloves of the Stonereaper")
          item(boss, "Greaves of the Rockmender")
          item(boss, "Libram of the Resolute")
          item(boss, "Platinum Band of the Aesir")
          item(boss, "Ring of the Faithful Servant")
          item(boss, "Runescribed Blade")
          item(boss, "Sandals of the Ancient Keeper")
          item(boss, "Shoulderplates of the Eternal")
          item(boss, "Siren's Cry")
          item(boss, "Stonerender")
          item(boss, "Unbreakable Chestguard")
          item(boss, "Unwavering Stare")
        when 'Assembly of Iron'
          item(boss, "Ancient Iron Heaume")
          item(boss, "Belt of Colossal Rage", "Hard Mode")
          item(boss, "Drape of Mortal Downfall", "Hard Mode")
          item(boss, "Drape of the Lithe")
          item(boss, "Fang of Oblivion", "Hard Mode")
          item(boss, "Greaves of Swift Vengeance", "Hard Mode")
          item(boss, "Handguards of the Enclave")
          item(boss, "Insurmountable Fervor")
          item(boss, "Iron-studded Mantle")
          item(boss, "Overload Legwraps")
          item(boss, "Radiant Seal")
          item(boss, "Raiments of the Iron Council")
          item(boss, "Rapture")
          item(boss, "Rune Edge")
          item(boss, "Runed Ironhide Boots")
          item(boss, "Runeshaper's Gloves")
          item(boss, "Sapphire Amulet of Renewal", "Hard Mode")
          item(boss, "Shoulderpads of the Intruder", "Hard Mode")
          item(boss, "Steelbreaker's Embrace")
          item(boss, "Unblinking Eye")
        when 'Hodir'
          item(boss, "Bindings of Winter Gale", "Hard Mode")
          item(boss, "Breastplate of the Wayward Conqueror")
          item(boss, "Breastplate of the Wayward Protector")
          item(boss, "Breastplate of the Wayward Vanquisher")
          item(boss, "Constellus", "Hard Mode")
          item(boss, "Drape of Icy Intent", "Hard Mode")
          item(boss, "Frigid Strength of Hodir", "Hard Mode")
          item(boss, "Frost-bound Chain Bracers")
          item(boss, "Frostplate Greaves")
          item(boss, "Frozen Loop")
          item(boss, "Gloves of the Frozen Glade", "Hard Mode")
          item(boss, "Staff of Endless Winter", "Hard Mode")
          item(boss, "Winter's Icy Embrace")
        when 'Thorim'
          item(boss, "Belt of the Betrayed")
          item(boss, "Crown of the Wayward Conqueror")
          item(boss, "Crown of the Wayward Protector")
          item(boss, "Crown of the Wayward Vanquisher")
          item(boss, "Embrace of the Gladiator", "Hard Mode")
          item(boss, "Fate's Clutch", "Hard Mode")
          item(boss, "Pauldrons of the Combatant", "Hard Mode")
          item(boss, "Scale of Fates")
          item(boss, "Sif's Promise")
          item(boss, "Skyforge Crossbow")
          item(boss, "Vulmir, the Northern Tempest")
          item(boss, "Warhelm of the Champion", "Hard Mode")
          item(boss, "Wisdom's Hold", "Hard Mode")
        when 'Freya'
          item(boss, "Bladetwister", "Hard Mode")
          item(boss, "Boots of the Servant")
          item(boss, "Bronze Pendant of the Vanir", "Hard Mode")
          item(boss, "Drape of the Sullen Goddess", "Hard Mode")
          item(boss, "Dreambinder", "Hard Mode")
          item(boss, "Gauntlets of Ruthless Reprisal")
          item(boss, "Handguards of Revitalization", "Hard Mode")
          item(boss, "Leggings of the Enslaved Idol", "Hard Mode")
          item(boss, "Leggings of the Lifetender")
          item(boss, "Legplates of the Wayward Conqueror")
          item(boss, "Legplates of the Wayward Protector")
          item(boss, "Legplates of the Wayward Vanquisher")
          item(boss, "The Lifebinder")
          item(boss, "Titanskin Cloak")
        when 'Mimiron'
          item(boss, "Armbands of Bedlam", "Hard Mode")
          item(boss, "Conductive Seal", "Hard Mode")
          item(boss, "Crown of Luminescence", "Hard Mode")
          item(boss, "Delirium's Touch", "Hard Mode")
          item(boss, "Gauntlets of the Wayward Conqueror")
          item(boss, "Gauntlets of the Wayward Protector")
          item(boss, "Gauntlets of the Wayward Vanquisher")
          item(boss, "Insanity's Grip")
          item(boss, "Malleable Steelweave Mantle")
          item(boss, "Pandora's Plea")
          item(boss, "Titanskin Cloak", "Hard Mode")
          item(boss, "Starshard Edge", "Hard Mode")
          item(boss, "Waistguard of the Creator")
        when 'General Vezax'
          item(boss, "Belt of Clinging Hope")
          item(boss, "Belt of the Darkspeaker")
          item(boss, "Boots of the Forgotten Depths")
          item(boss, "Boots of the Underdweller")
          item(boss, "Flare of the Heavens", "Hard Mode")
          item(boss, "Grips of the Unbroken")
          item(boss, "Handwraps of the Vigilant", "Hard Mode")
          item(boss, "Helm of the Faceless")
          item(boss, "Idol of the Corruptor")
          item(boss, "Libram of Discord")
          item(boss, "Libram of the Sacred Shield")
          item(boss, "Lotrafen, Spear of the Damned")
          item(boss, "Mantle of the Unknowing")
          item(boss, "Metallic Loop of the Sufferer")
          item(boss, "Pendulum of Infinity", "Hard Mode")
          item(boss, "Ring of the Vacant Eye")
          item(boss, "Scepter of Lost Souls")
          item(boss, "The General's Heart")
          item(boss, "Vestments of the Blind Denizen", "Hard Mode")
          item(boss, "Voldrethar, Dark Blade of Oblivion", "Hard Mode")
        when 'Yogg-Saron'
          item(boss, "Blood of the Old God")
          item(boss, "Chestguard of Insidious Intent")
          item(boss, "Chestguard of the Fallen God")
          item(boss, "Cowl of Dark Whispers")
          item(boss, "Dark Edge of Depravity", "Hard Mode")
          item(boss, "Earthshaper")
          item(boss, "Garona's Guise")
          item(boss, "Godbane Signet")
          item(boss, "Legguards of Cunning Deception", "Hard Mode")
          item(boss, "Mantle of the Wayward Conqueror")
          item(boss, "Mantle of the Wayward Protector")
          item(boss, "Mantle of the Wayward Vanquisher")
          item(boss, "Sanity's Bond")
          item(boss, "Seal of the Betrayed King", "Hard Mode")
          item(boss, "Shawl of Haunted Memories")
          item(boss, "Show of Faith", "Hard Mode")
          item(boss, "Soulscribe")
          item(boss, "Treads of the False Oracle", "Hard Mode")
          item(boss, "Vanquished Clutches of Yogg-Saron")
        when 'Algalon the Observer'
          item(boss, "Boundless Gaze")
          item(boss, "Bulwark of Algalon")
          item(boss, "Constellus")
          item(boss, "Cosmos")
          item(boss, "Dreambinder")
          item(boss, "Fang of Oblivion")
          item(boss, "Legplates of the Endless Void")
          item(boss, "Pharos Gloves")
          item(boss, "Reply-Code Alpha")
          item(boss, "Sabatons of Lifeless Night")
          item(boss, "Skyforge Crossbow")
          item(boss, "Solar Bindings")
          item(boss, "Star-beaded Clutch")
          item(boss, "Starshard Edge")
          item(boss, "Starwatcher's Binding")
        end
      end
    end
  end
end