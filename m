From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 Nov 2013 13:29:52 +0000
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
In-Reply-To: <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
Message-ID: <20131113132952.GK878@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
> On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie@kernel.org> wrote:

> > Applied, thanks.

> These warnings are showing up (again?), so wherever it was applied is
> not making it into -next. Did it fall between the cracks?

Looks lie it never got pushed and nobody looked at the warnings for over
a month.  Oh well, sorry about that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131113/1d7b541a/attachment.sig>
