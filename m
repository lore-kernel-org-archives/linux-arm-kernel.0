From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Sep 2015 11:28:07 +0200
Subject: [PATCH v4 1/2] ARM: dma-mapping: Don't use outer_flush_range when
 the L2C is coherent
In-Reply-To: <20150929171054.GN21513@n2100.arm.linux.org.uk> (Russell King's
 message of "Tue, 29 Sep 2015 18:10:54 +0100")
References: <1443545458-14807-1-git-send-email-gregory.clement@free-electrons.com>
 <1443545458-14807-2-git-send-email-gregory.clement@free-electrons.com>
 <20150929171054.GN21513@n2100.arm.linux.org.uk>
Message-ID: <87fv1wqms8.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

 On mar., sept. 29 2015, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Sep 29, 2015 at 06:50:57PM +0200, Gregory CLEMENT wrote:
>> When a L2 cache controller is used in a system that provides hardware
>
> You're talking about L2 cache here, but you're also masking out the L1
> cache maintanence (dmac_*) too.  It's my understanding that we don't
> yet support coherency to L1 yet.

Do you suggest to not masking the dmac_* operation ?

Initially I tought that L1 and L2 cache maintanence operation were more
or less linked but I might mix up.

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
