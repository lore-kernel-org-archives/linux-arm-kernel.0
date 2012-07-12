From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 12 Jul 2012 14:02:34 +0100
Subject: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
In-Reply-To: <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <20120711174908.GP3938@opensource.wolfsonmicro.com>
 <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
 <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
Message-ID: <20120712130234.GE3957@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 06:11:05PM +0900, Kukjin Kim wrote:

> And Mark, this touches various samsung stuff in arch/arm/ so if you're ok,
> I'd like to pick this up in samsung tree. We don't want to see conflicts...

Well, simple conflicts aren't that big a deal...  However, Thomas
mentioned that in order to test this he merged the SPI tree into your
tree so perhaps there is also a dependency on the SPI tree?  If that was
just for good practice testing then I agree that the best thing is to
merge via your tree, otherwise we might need to think harder.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120712/18d66137/attachment.sig>
