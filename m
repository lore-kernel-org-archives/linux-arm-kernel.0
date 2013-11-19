From: trini@ti.com (Tom Rini)
Date: Tue, 19 Nov 2013 14:06:04 -0500
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <201311191505.33636.arnd@arndb.de>
 <20131119152157.GO5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119190604.GH420@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 03:21:57PM +0000, Mark Rutland wrote:
[snip]
> I think that with ACPI systems the data we would have to convert is
> going to be larger and more varied than that. Given we already have code
> in the kernel for handling ACPI, I believe it would be more valuable to
> leverage that and support ACPI directly in those places which require it

I'll bite.  How realistic a proprosition is that?  When I've talked with
a few folks here and there they say, roughly, that "the ARM bit" being
set means it's a whole new ball game, and no, they don't expect to be
able to re-use a lot of the existing code.

-- 
Tom
