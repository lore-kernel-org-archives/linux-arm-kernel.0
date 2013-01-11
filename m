From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 11 Jan 2013 15:45:04 +0100
Subject: [PATCH v2] arm: mvebu: add DTS file for Marvell RD-A370-A1 board
In-Reply-To: <3816648.2TVsTiMOWx@bender>
References: <1588881.pi23bvqp7D@bender> <3816648.2TVsTiMOWx@bender>
Message-ID: <50F02570.9050208@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas, Gregory,

Le 01/09/13 20:56, Florian Fainelli a ?crit :
> This patch adds the DTS file to support the Marvell RD-A370-A1
> (Reference Design board) also known as RD-88F6710 board. It is almost
> entirely similar to the DB-A370 board except that the first Ethernet PHY
> is SGMII-wired and the second is a switch which is RGMII-wired.

Who is going to take this patch? Since this is a new DTS file there are 
little chances it breaks anything, could it be taken for an upcoming 3.8-rc?

Thanks.
--
Florian
