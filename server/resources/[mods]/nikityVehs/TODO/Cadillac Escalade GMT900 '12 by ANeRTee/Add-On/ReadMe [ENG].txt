[How to add this car as an add-on]

Installation:
[Editing the dlclist.xml]
1. Create a folder named "gmt900escalade" in :\Grand Theft Auto V\mods\update\x64\dlcpacks 
2. Open OpenIV and extract the "dlc.rpf" from the current archive to \Grand Theft Auto V\update\x64\dlcpacks\gmt900escalade
3. Add the following line: 

		<Item>dlcpacks:\gmt900escalade\</Item>

4. Save the changes and copy the edited "dlclist.xml" back to: \Grand Theft Auto V\update\update.rpf\common\data

[Editing the extratitleupdatedata.meta]
5. Using OpenIV, go to: \Grand Theft Auto V\update\update.rpf\common\data — and extract the "extratitleupdatedata.meta" in some folder of your choice.
6. Add the following line:

		<Item type="SExtraTitleUpdateMount">
			<deviceName>dlc_gmt900escalade:/</deviceName>
			<path>update:/dlc_patch/gmt900escalade/</path>
		</Item>

7. Save the changes and copy the edited "extratitleupdatedata.meta" to: \Grand Theft Auto V\update\update.rpf\common\data
8. Then, go to :\Grand Theft Auto V — open trainerv.ini — Search (Ctrl+F) — "//Added Cars //" section
9. Change Enable1=0 to Enable1=1
10. Change ModelName1=turismo to ModelName1=gmt900escalade
11. Change DisplayName1=Car 1 to DisplayName1=Cadillac Escalade
12. Save the changes and copy the edited "trainerv.ini" to: \Grand Theft Auto V

Done!

Add-On, instruction, all settings by Alex9581 http://maniamods.ru/