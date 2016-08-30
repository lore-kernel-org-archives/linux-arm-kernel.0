From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Aug 2016 19:46:12 +0100
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <87k2eycip0.fsf@belgarion.home>
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
 <87k2eycip0.fsf@belgarion.home>
Message-ID: <20160830184612.GO1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 06:42:03PM +0200, Robert Jarzmik wrote:
> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
> 
> > On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
> >> Maybe this one would deserve a doxygen comment ?
> >
> > Does this solve it?
> Oh yes, that's very nice, especially the "1 = in" for which I have always a
> doubt.
> 
> Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>
> 
> I hope to have an "attempt" to test all your series on the lubbock board in the
> next days. The "attempt" part is because last time I checked pcmcia support was
> broken on lubbock (ie. CONFIG_PCMCIA_SA1111 activated implies an Oops), and I
> don't remember having repaired it (and it's disabled on my test farm which is a
> sign I was not very confident about this part).
> 
> If you happen to have somewhere a branch I can pull, with all your series (at
> least "[RFC PATCH 00/33] SA11x0/PXA GPIO rework (Core + PCMCIA only)" and
> "[PATCH 0/8] SA11x0/PXA remainder & cleanups"), that would spare me the multiple
> git-am to make the test(s).

If you can wait a day or two, I'll push a branch out for everything in
all these multiple series.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
