From: rusko.peter@prolan.hu (Peter Rusko)
Date: Tue, 11 Oct 2011 16:33:09 +0200
Subject: TX28 drivers - Please help
Message-ID: <4E9453A5.2000501@prolan.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

We'd like to use the Ka-Ro TX28 module in a device with our company.
As I could see, not all the features of it's processor are supported. I 
have already added some of them using the Freescale version just to see 
that things are working, but the code became really messy. So I've 
decided to restart, and this time I'd like to commit the changes to the 
mainline kernel.

We have already designed a company board supporting the TX28 module. The 
first problem I don't know how to do well is to separate the module and 
the baseboard. I think that the module-specific things and setup should 
be in a file like mach-tx28.c (as it already is), and the board specific 
things should be in a separate file (mach-karo_stk.c ?). I'm quite 
unsure about the naming and where I should split the code.

After that works, I'd like to include support for SPI and the mxs 
touchscreen driver (which also needs the LRADC support).

How should I start? I've already downloaded the pengutronix/imx 
repository to work with.
-- 
Rusk? P?ter
fejleszt?m?rn?k

Prolan Zrt. / Prolan Co.
Hungary 2011 Budakal?sz, Szentendrei ?t 1-3.
Tel./Phone: +36 20 954 3118
Fax: +36 26 540 420
E-mail: rusko.peter at prolan.hu
Web: www.prolan.hu
Timezone:CET
