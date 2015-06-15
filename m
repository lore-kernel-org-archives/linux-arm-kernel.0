From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jun 2015 16:57:53 +0200
Subject: [PATCH] ARM: mm: enable L1 prefetch on Cortex-A9
In-Reply-To: <20150615111103.GL7557@n2100.arm.linux.org.uk>
References: <1434023550-20147-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150615111103.GL7557@n2100.arm.linux.org.uk>
Message-ID: <20150615165753.61d8c75a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Mon, 15 Jun 2015 12:11:03 +0100, Russell King - ARM Linux wrote:

> I'd prefer not to take this until after the next merge window, because I
> don't want to deal with conflicts that this may cause with other branches
> in my tree.
> 
> We're at -rc8 now, only a week away from -final, now is not really the
> time to be taking new code into git trees anyway.

I should have mentioned that explicitly, but I clearly didn't expect
this patch to be taken for the upcoming 4.2 merge window as it's way
too late. Targeting 4.3 is perfectly fine.

However, can you consider my "ARM: smp_scu: enable coherent speculative
linefills", which has been sent almost three months ago:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/332106.html

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
