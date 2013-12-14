From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 14 Dec 2013 20:02:38 +0100
Subject: [PATCH 02/12] SPEAr13xx: Move SPEAr1340 definitions to header file
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <201312112348.06755.arnd@arndb.de>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F669D@EAPEX1MAIL1.st.com>
Message-ID: <201312142002.38423.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 December 2013, Mohit KUMAR DCG wrote:
> > The RST bits should probably go into a drivers/reset driver. Not sure what the
> > other registers do, but I'm sure we can find a driver for these too, possibly
> > they should be part of the PHY driver?
> 
> -  Perhaps if we implement phy and reset driver then we may not require to move these definitions and
> it will address most of your comments on SPEar13xx pcie driver. I am understanding and working on this.l 
> 

Ok, very good.

	Arnd
