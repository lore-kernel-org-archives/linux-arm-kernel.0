From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 31 Mar 2013 20:33:53 +0200
Subject: PCI support for IMX6
In-Reply-To: <CAOMZO5Df3wFhT=Mbpct1nR1UrZWSq9_emfTp8i2imJaWoLmfEw@mail.gmail.com>
References: <20130329185500.GB30029@amd.pavel.ucw.cz>
 <20130330113703.GA21042@amd.pavel.ucw.cz>
 <CAOMZO5Df3wFhT=Mbpct1nR1UrZWSq9_emfTp8i2imJaWoLmfEw@mail.gmail.com>
Message-ID: <20130331183353.GB25751@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +#define SBC6X_PCIE_PWR                  IMX_GPIO_NR(1, 3)
> > +#define SBC6X_PCIE_RST                  IMX_GPIO_NR(1, 8)
> 
> These pins need to be programmed as GPIO in the dts file.

I know. I'm trying to get it working before the clean up.

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
