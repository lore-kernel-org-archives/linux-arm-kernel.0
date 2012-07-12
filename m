From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jul 2012 17:16:57 +0100
Subject: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
In-Reply-To: <CAJuYYwS59yoRnyFOR4_M5ymAS5uh0fN5zS=x2CS5Ax-795awBA@mail.gmail.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <20120711174908.GP3938@opensource.wolfsonmicro.com>
 <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
 <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
 <20120712130234.GE3957@opensource.wolfsonmicro.com>
 <CAJuYYwS59yoRnyFOR4_M5ymAS5uh0fN5zS=x2CS5Ax-795awBA@mail.gmail.com>
Message-ID: <20120712161657.GC7256@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 07:13:37PM +0530, Thomas Abraham wrote:
> On 12 July 2012 18:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Well, simple conflicts aren't that big a deal...  However, Thomas
> > mentioned that in order to test this he merged the SPI tree into your
> > tree so perhaps there is also a dependency on the SPI tree?  If that was
> > just for good practice testing then I agree that the best thing is to
> > merge via your tree, otherwise we might need to think harder.

> There were no dependency on Grant's spi/next branch. It was merged
> just to ensure that nothing is broken.

OK, great - then the Samsung tree it is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/d20848c7/attachment.sig>
