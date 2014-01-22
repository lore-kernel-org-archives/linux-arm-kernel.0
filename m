From: denis@eukrea.com (Denis Carikli)
Date: Wed, 22 Jan 2014 14:56:09 +0100
Subject: [PATCHv5][ 6/8] ARM: dts: mbimx51sd: Add display support.
In-Reply-To: <201312052156.50236.marex@denx.de>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-6-git-send-email-denis@eukrea.com>
 <201312052156.50236.marex@denx.de>
Message-ID: <52DFCDF9.7050309@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 09:56 PM, Marek Vasut wrote:
>> +++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard-cmo-qvga.dts
[...]
>> +&display {
>> +	display-supply = <&reg_lcd_3v3>;
>> +	status = "okay";
>
> The "status = " here should probably be in the board DTS, not in the LCD DTS.
The display is optional on the baseboard of the cpuimx51.

So my idea was to activate the display only for the configurations where 
it's used.

Denis.
