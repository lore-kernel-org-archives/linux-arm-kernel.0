From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Tue, 7 Nov 2017 17:38:55 +0100
Subject: [PATCH 1/1] add rgb888 pins to a20 to enable parallel rgb LCD
In-Reply-To: <20171107130331.4wut5g6znzakkg4z@flea>
References: <1510058999-6778-1-git-send-email-giulio.benetti@micronovasrl.com>
 <20171107130331.4wut5g6znzakkg4z@flea>
Message-ID: <65694f1d-e1cb-08e0-0883-f0087f5e09f5@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board could be any with A20,
for example Olinuxino A20.
Or our Q027, S027 boards, but final dts still are not complete.

-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

Il 07/11/2017 14:03, Maxime Ripard ha scritto:
> On Tue, Nov 07, 2017 at 01:49:59PM +0100, Giulio Benetti wrote:
>> On sun7i-a20-* there's no way to enable PA00--PA27 as RGB888 LCD0 pins.
>>
>> Add lcd_rgb888_pins in sun7i-a20.dtsi.
>>
>> It can be used on sun7i-a20-olinuxino-lime.dts.
>> This patch gives possibility to set parallel lcd pins for RGB888.
>> To be used with tcon0 in your <target>.dts
> 
> My question was on which board do you want to use it right now. If the
> answer is none, then we won't merge that patch, we have too many
> pinctrl already to not add the unused ones.
> 
> Maxime
> 
