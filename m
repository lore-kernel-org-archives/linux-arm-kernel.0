From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 11:39:21 +0200
Subject: [PATCHv4 2/6] ARM: dts: Add initial LS1021A QDS board dts support
In-Reply-To: <7ecfaed8cb1b4c228ee2eb20aab33429@BL2PR03MB467.namprd03.prod.outlook.com>
References: <1411371952-5618-1-git-send-email-jingchang.lu@freescale.com>
 <20140926061354.GD31948@dragon>
 <7ecfaed8cb1b4c228ee2eb20aab33429@BL2PR03MB467.namprd03.prod.outlook.com>
Message-ID: <5453997.HOc1sLj4Fj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 28 September 2014 08:48:17 Jingchang Lu wrote:
> >> +            i2c at 3 {
> >> +                    #address-cells = <1>;
> >> +                    #size-cells = <0>;
> >> +                    reg = <0x3>;
> >> +
> >> +                    eeprom at 56 {
> >> +                            compatible = "at24,24c512";
> >
> >Undocumented property.
> It documented in Documentation/devicetree/bindings/eeprom.txt as the form of "<manufacturer>,<type>". Thanks.
> >
> 

The documented vendor name for Atmel is "atmel", not "at24".

	Arnd
