From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 Jul 2014 20:37:56 +0100
Subject: [PATCH] ASoC: tda998x: add a codec to the HDMI transmitter
In-Reply-To: <20140702180212.GS32514@n2100.arm.linux.org.uk>
References: <20140702183841.7c964832@armhf> <20140702165628.GO20799@lunn.ch>
 <20140702195154.47d6f6b4@armhf>
 <20140702180212.GS32514@n2100.arm.linux.org.uk>
Message-ID: <20140702193756.GM410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 02, 2014 at 07:02:12PM +0100, Russell King - ARM Linux wrote:

> Well, as far as I'm concerned right now, it's for Mark to sort out this
> situation, and tell us what he wants to do with the Kirkwood stuff.  I
> suspect he's keeping quiet because he doesn't care about it.

Well, that and the general level of stress around the support for these
boards in general.  

> Given that he's the one with the knowledge of DPCM, and he's the maintainer
> of ASoC, he has the ultimate responsibility for sorting out this and
> giving direction as to how he wants to proceed.

> As I understand it though, my solution is the full and proper DPCM solution,
> and I believe that what's currently in mainline is not a DPCM solution.

That's right, from what I remember your last set of patches looked like
it was pretty much there in terms of the code for the CPU.  Liam's
obviously the most in depth expert with DPCM but he's incredibly snowed
under with work right now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/6be10f4f/attachment.sig>
