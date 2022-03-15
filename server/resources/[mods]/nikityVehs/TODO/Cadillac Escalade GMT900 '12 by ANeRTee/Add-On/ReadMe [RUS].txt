”становка:

1. —оздайте папку под названием "gmt900escalade" по пути:\Grand Theft Auto V\mods\update\x64\dlcpacks
2. ѕри помощи OpenIV Ч извлеките "dlc.rpf" из данного архива Ч по пути: \Grand Theft Auto V\update\x64\dlcpacks\gmt900escalade

[–едактирование dlclist.xml]
3. ѕри помощи OpenIV Ч перейдите по пути:\Grand Theft Auto V\update\update.rpf\common\data Ч и извлеките файл"dlclist.xml" в удобное дл€ вас место
4. ƒобавьте в него новую строку: 

		<Item>dlcpacks:\gmt900escalade\</Item>

5. —охраните изменени€ и замените программой OpenIV Ч по пути:\Grand Theft Auto V\update\update.rpf\common\data

[–едактирование extratitleupdatedata.meta]
6. ѕри помощи OpenIV Ч перейдите по пути:\Grand Theft Auto V\update\update.rpf\common\data Ч и извлеките файл"extratitleupdatedata.meta" в удобное дл€ вас место
7. ƒобавьте в него новые строки:

		<Item type="SExtraTitleUpdateMount">
			<deviceName>dlc_gmt900escalade:/</deviceName>
			<path>update:/dlc_patch/gmt900escalade/</path>
		</Item>

8. —охраните изменени€ и замените программой OpenIV Ч по пути:\Grand Theft Auto V\update\update.rpf\common\data
9. ѕерейдите по пути: \Grand Theft Auto V Ч откройте trainerv.ini Ч при помощи поиска найдите раздел //Added Cars //
10. ¬ поле: Enable1=0 Ч мен€ем значение "0" на "1"
11. ¬ поле: ModelName1=turismor Ч мен€ем на - gmt900escalade
12. ¬ поле: DisplayName1=Car 1 Ч мен€ем на - Cadillac Escalade
13. —охраните изменени€ и замените программой OpenIV Ч по пути:\Grand Theft Auto V

”становка завершена!

»нструкци€, способ добавлени€ модели, настройки в GTA 5: Alex9581