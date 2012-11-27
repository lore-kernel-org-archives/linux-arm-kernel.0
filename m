From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Nov 2012 14:04:02 +0000
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
In-Reply-To: <87y5hn1tey.fsf@dell.be.48ers.dk>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
 <20121126114511.GE9411@opensource.wolfsonmicro.com>
 <87y5hn1tey.fsf@dell.be.48ers.dk>
Message-ID: <20121127140402.GE4468@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 09:55:33PM -0800, Peter Korsgaard wrote:
> >>>>> "Mark" == Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

>  Mark> Since the driver is happy to continue without the pins why is it
>  Mark> bothering requesting them in the first place?  In other words, this
>  Mark> should be a hard error.

> Sorry, I disagree. As was discussed recently, there's several reasons
> why the pinctrl call might fail, and not all are fatal (E.G. pinmux
> already setup by bootloader):

> http://article.gmane.org/gmane.linux.kernel/1399756

I'd expect the platform to provide stub mappings for cases where the
pinmux code shouldn't do anything.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121127/ebfb3682/attachment.sig>
