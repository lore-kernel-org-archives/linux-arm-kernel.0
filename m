From: vianney.leclement@essensium.com (Vianney le =?iso-8859-1?q?Cl=E9ment?=)
Date: Wed, 1 Apr 2015 15:25:36 +0200
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <CAOMZO5DM66sUX-YojCyY5BC3Pdk4p4bkEqQ+W3tyDeNEL6nU5w@mail.gmail.com>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <CAOMZO5DM66sUX-YojCyY5BC3Pdk4p4bkEqQ+W3tyDeNEL6nU5w@mail.gmail.com>
Message-ID: <1427894736.2449.2@mail.essensium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 1, 2015 at 1:39 , Fabio Estevam <festevam@gmail.com> wrote:
> On Wed, Apr 1, 2015 at 5:10 AM, Vianney le Cl?ment de Saint-Marcq
> <vianney.leclement@essensium.com> wrote:
>>  Add device tree for the Embest/Element 14 MarS Board [1], an i.MX6 
>> Dual
>>  based development board.
>> 
>>  The e-MMC chip is disabled because initialization fails (error 
>> -110).
>>  A possible cause is described in [2].
>> 
>>  [1] http://www.embest-tech.com/shop/star/marsboard.html
>>  [2] https://community.freescale.com/message/442168#442168
>> 
>>  Signed-off-by: Vianney le Cl?ment de Saint-Marcq 
>> <vianney.leclement@essensium.com>
> 
> Couldn't this be combined with the existing
> arch/arm/boot/dts/imx6dl-riotboard.dts?

While both boards do indeed share a lot of the schematics, the 
marsboard has some differences, e.g., in pin configuration, that 
requires a separate dts.  We could split common parts out in a new 
dtsi, but I am not sure it is worth the hassle.

Regards,
Vianney

Vianney le Cl?ment de Saint-Marcq
Embedded Software Developper ? +32 485 84 55 05
Essensium, Mind division ? www.mind.be
GPG: 727B CFE9 355F 1B02 0820 EE1C 9042 3E07 A804 0316
