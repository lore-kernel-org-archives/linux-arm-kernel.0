From: broonie@kernel.org (Mark Brown)
Date: Thu, 4 Jun 2015 11:26:21 +0100
Subject: [PATCH 10/11] spi: add more debug prints in s3c64xx
In-Reply-To: <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
References: <cover.1433364398.git.hramrach@gmail.com>
 <305830ebf9c0ae98c4f6e0ebbdec7414d6762b36.1433364398.git.hramrach@gmail.com>
 <20150604091634.GY14071@sirena.org.uk>
 <CAOMqctQxn6UY2DJ9Syp6Ay9SYKLgdU+8EjiTK_48-R3dZ8PcvA@mail.gmail.com>
Message-ID: <20150604102621.GB14071@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 11:33:37AM +0200, Michal Suchanek wrote:
> On 4 June 2015 at 11:16, Mark Brown <broonie@kernel.org> wrote:

> > Also for this patch (which just adds some trace) there isn't any clear
> > reason for it to be sent as part of the series at all, it doesn't help
> > deliver the functionality and doesn't depend on the rest of the series.

> I used this patch to add missing information to dmesg output so I
> could diagnose the SPI failures so I think it is relevant.

The fact that you used this to debug problems is not relevant to any fix
you might have developed for those problems; the fix can be explained
without needing to know how you got there.  Similarly the debugging is
hopefully useful in general without needing to know which particular
problem prompted it's creation.

> To print a clock name you AFAICT need this header. I think this is an
> abstraction problem in the clock framework. Fixing the abstraction
> problem with clock framework would only grow the list of recipients
> which is already so long you complain about it.

This is a bit of a warning sign that the series isn't very focused.
It's also just not good practice, sending patches with obvious problems
(especially obvious problems that aren't clearly flagged up as something
temporary) will frustrate reviewers and can often lead to other issues
being obscured.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150604/f2edb94c/attachment.sig>
