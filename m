From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 27 Oct 2015 12:41:15 +0000
Subject: [PATCH] ARM64: juno: add NOR flash to device tree
In-Reply-To: <20151027123334.GC3091@leverpostej>
References: <5624C31D.3070906@arm.com> <20151019102932.GB10678@leverpostej>
 <CACRpkdaGscb_ccbGuwccsRj_b1d6xoveiiZpw1a5eXon3PxAUA@mail.gmail.com>
 <20151019113904.GE10678@leverpostej>
 <CACRpkdb1XRSq3EERbiMwCnuV7Dtit2xGYRDBtQ9+odyXq6kM7A@mail.gmail.com>
 <20151020112026.GF10728@bivouac.eciton.net>
 <CAD0U-hKZM-A2N_Lpnzwkt0WmAi+kRR=UOEE4Vr2M-iTo9ikkOg@mail.gmail.com>
 <CACRpkdZ2Ydyzf9rHOgjZ_KhhxqFi_cK1-Jh47Fh+SP4YGjg_EA@mail.gmail.com>
 <562F6799.1060301@arm.com>
 <CACRpkdbpD+Kr01hDc7QnL4x_4=A_rnAO+G0CaMce8+5ns+bx2Q@mail.gmail.com>
 <20151027123334.GC3091@leverpostej>
Message-ID: <562F70EB.2000008@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/10/15 12:33, Mark Rutland wrote:

[...]

>
> * Sudeep, I assume the constraints on CPU_SUSPEND would also apply to
>    CPU_ON, is that correct?
>

Yes, if you meant that this is an issue for even CPU hotplug. We need to
disable CPU_HOTPLUG in that case which is horrible.

So this kind of conditional compile is simply not a solution to
support/work around an hardware issue on one platform.

-- 
Regards,
Sudeep
