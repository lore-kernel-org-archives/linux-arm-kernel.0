From: broonie@kernel.org (Mark Brown)
Date: Sun, 24 Nov 2013 13:31:03 +0000
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
In-Reply-To: <52911B64.3020009@ti.com>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
 <20131113132952.GK878@sirena.org.uk> <52911B64.3020009@ti.com>
Message-ID: <20131124133103.GS14725@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 04:17:24PM -0500, Santosh Shilimkar wrote:
> On Wednesday 13 November 2013 08:29 AM, Mark Brown wrote:

> > Looks lie it never got pushed and nobody looked at the warnings for over
> > a month.  Oh well, sorry about that.

> Are you going to push this one ? The warning is still showing up at
> 3.13-rc1.

It's a warning fix only so no, I was going to leave it till the next
merge window.  It'll appear in -next as soon as Linus releases -rc1.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131124/32bd6646/attachment.sig>
