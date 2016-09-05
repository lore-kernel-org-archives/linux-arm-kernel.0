From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Sep 2016 13:28:10 +0100
Subject: [PATCH 0/6] SA11x0 serial updates
In-Reply-To: <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
 <20160829120531.GG1041@n2100.armlinux.org.uk>
 <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
Message-ID: <20160905122810.GP1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 11:09:38AM +0200, Linus Walleij wrote:
> On Mon, Aug 29, 2016 at 2:05 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > This series converts SA11x0 serial to make use of the mctrl helpers
> > where appropriate.  This allows us to remove several board-specific
> > callbacks.
> 
> >From GPIO and H3600 point of view:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks - did you check that the appropriate GPIOs were claimed for
serial in gpio's debugfs?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
