From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 17 Jul 2012 15:05:14 +0100
Subject: Device tree.
In-Reply-To: <50056E22.5040308@gmail.com>
References: <500552C9.4090107@codethink.co.uk> <20120717140100.7c0ae90c@skate>
 <500556CF.6030704@codethink.co.uk>
 <CAMW5UfZR5qrY4K=ty9HDcd9UqYGtfZitH0CBgDbZWvpAoTve2Q@mail.gmail.com>
 <50056391.3060208@codethink.co.uk>
 <8f3d9be256cbe0feec86cca6aaefd437@codethink.co.uk>
 <50056E22.5040308@gmail.com>
Message-ID: <20120717140514.GA3107@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 08:52:34AM -0500, Rob Herring wrote:
> On 07/17/2012 08:25 AM, Ben Dooks wrote:

> > This means in u-boot, you just need to load the .dts file
> > into place before booting the kernel.

> You mean dtb...

> But no, we don't need a 3rd boot interface in the kernel. I don't see
> why cat + mkimage is too hard to run.

> Now that u-boot has direct support for zImage booting, I doubt anything
> uImage building related will ever be accepted into the kernel.

u-boot isn't the only bootloader that does uImage, and of course the
issue here is people stuck with old bootloaders that they don't want to
upgrade for whatever reason (or just don't want to let the bootloader
know about DT due to the incompatibility with non-DT kernels) so the
availability of new bootloaders doesn't help as much as it should.
