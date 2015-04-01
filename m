From: vianney.leclement@essensium.com (Vianney le =?iso-8859-1?q?Cl=E9ment?=)
Date: Wed, 1 Apr 2015 10:32:06 +0200
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <1427876156.24886.1.camel@pengutronix.de>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
 <1427876156.24886.1.camel@pengutronix.de>
Message-ID: <1427877126.2449.0@mail.essensium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 1, 2015 at 10:15 , Lucas Stach <l.stach@pengutronix.de> 
wrote:
> Am Mittwoch, den 01.04.2015, 10:10 +0200 schrieb Vianney le Cl?ment 
> de
> Saint-Marcq:
>>  Add device tree for the Embest/Element 14 MarS Board [1], an i.MX6 
>> Dual
>>  based development board.
>> 
>>  The e-MMC chip is disabled because initialization fails (error 
>> -110).
>>  A possible cause is described in [2].
> 
> So if the problem is that there are only 4 connected data lines one 
> the
> board, couldn't you simply add the property bus-width = <4>; to the 
> emmc
> node?

It is already the case (imx6qdl.dtsi, line 929), but to no avail.  That 
is why I wrote "possible" cause as I did not find any evidence of the 
described behaviour in my (admittedly limited) investigations.


Vianney le Cl?ment de Saint-Marcq
Embedded Software Developper ? +32 485 84 55 05
Essensium, Mind division ? www.mind.be
GPG: 727B CFE9 355F 1B02 0820 EE1C 9042 3E07 A804 0316
