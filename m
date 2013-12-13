From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 13 Dec 2013 11:51:09 +0100
Subject: [PATCH] ARM: reinsert ARCH_MULTI_V4 Kconfig option
In-Reply-To: <20131213095655.GB4360@n2100.arm.linux.org.uk>
References: <1386922149-4561-1-git-send-email-jonas.jensen@gmail.com>
 <20131213095655.GB4360@n2100.arm.linux.org.uk>
Message-ID: <CACmBeS1d-EX5oPD8f7P-ufmF=MutdTO+LgG23Cb0=biR8yQPCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 December 2013 10:56, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> So, having these symbols enabled (provided the right ones for FA526 are
> also enabled) makes no difference.  So I don't buy your explanation.

The explanation is indeed false, CPU_FA526 and CPU_ARM920T get along just fine.
That's not where the problem is.

Panic goes away after removing CONFIG_ARM_THUMB=y.

I assume this is what should happen on processors without thumb?

Thanks,
Jonas
