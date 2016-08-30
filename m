From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 30 Aug 2016 18:42:03 +0200
Subject: [PATCH 05/33] gpio: add generic single-register fixed-direction
 GPIO driver
In-Reply-To: <20160830091805.GL1041@n2100.armlinux.org.uk> (Russell King's
 message of "Tue, 30 Aug 2016 10:18:06 +0100")
References: <20160829102328.GA28796@n2100.armlinux.org.uk>
 <E1beJjz-0000mA-0o@rmk-PC.armlinux.org.uk>
 <87eg57e54l.fsf@belgarion.home>
 <20160830091805.GL1041@n2100.armlinux.org.uk>
Message-ID: <87k2eycip0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@armlinux.org.uk> writes:

> On Mon, Aug 29, 2016 at 09:39:54PM +0200, Robert Jarzmik wrote:
>> Maybe this one would deserve a doxygen comment ?
>
> Does this solve it?
Oh yes, that's very nice, especially the "1 = in" for which I have always a
doubt.

Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

I hope to have an "attempt" to test all your series on the lubbock board in the
next days. The "attempt" part is because last time I checked pcmcia support was
broken on lubbock (ie. CONFIG_PCMCIA_SA1111 activated implies an Oops), and I
don't remember having repaired it (and it's disabled on my test farm which is a
sign I was not very confident about this part).

If you happen to have somewhere a branch I can pull, with all your series (at
least "[RFC PATCH 00/33] SA11x0/PXA GPIO rework (Core + PCMCIA only)" and
"[PATCH 0/8] SA11x0/PXA remainder & cleanups"), that would spare me the multiple
git-am to make the test(s).

Cheers.

--
Robert
