From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 17 Jul 2017 22:20:25 +0100
Subject: [PATCH resend] Documentation: arm: Replace use of virt_to_phys
 with __pa_symbol
In-Reply-To: <20170717134445.22a1b00d@lwn.net>
References: <1500298768-13262-1-git-send-email-geert+renesas@glider.be>
 <20170717134445.22a1b00d@lwn.net>
Message-ID: <20170717212025.GM31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 01:44:45PM -0600, Jonathan Corbet wrote:
> On Mon, 17 Jul 2017 15:39:28 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> 
> > All low-level PM/SMP code using virt_to_phys() should actually use
> > __pa_symbol() against kernel symbols.  Update the documentation to move
> > away from virt_to_phys().
> > 
> > Cfr. commit 6996cbb2372189f7 ("ARM: 8641/1: treewide: Replace uses of
> > virt_to_phys with __pa_symbol")
> 
> I was kind of hoping for an ack from somebody on this, but, four months
> later, I'll take the absence of complaints as being enough.  Applied,
> thanks.

Maybe those who contributed Documentation/arm/firmware.txt should
have responded, seems that was Tomasz Figa <t.figa@samsung.com>
who isn't even on the Cc list for this...

Can't blame people who aren't copied with the patch for not
responding.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
