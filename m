From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 19 Aug 2015 23:28:39 +0100
Subject: [PATCH v4 1/2] arm64: KVM: Optimize arm64 skip 30-50% vfp/simd
 save/restore on exits
In-Reply-To: <55D4FA88.5060305@samsung.com>
References: <1437082178-11039-1-git-send-email-m.smarduch@samsung.com>
 <1437082178-11039-2-git-send-email-m.smarduch@samsung.com>
 <55C235B9.3000800@arm.com> <20150819174958.GA11518@cbox>
 <55D4FA88.5060305@samsung.com>
Message-ID: <20150819232839.69531eca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Aug 2015 14:52:08 -0700
Mario Smarduch <m.smarduch@samsung.com> wrote:

> Hi Christoffer,
>    I'll test it and work with it.

FWIW, I've added these patches to both -queue and -next, and from the
tests Christoffer has run, it looks pretty good.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
