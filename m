From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Feb 2011 15:58:52 -0000
Subject: [PATCH 4/5] ARM: s5pv310: update IRQ combiner to use EOI in
	parent chip
In-Reply-To: <AANLkTimiPEsb_S3tv+yPOr=p8UageK_-er9HkjM10ro5@mail.gmail.com>
References: <1298302096-21275-1-git-send-email-will.deacon@arm.com>	<1298302096-21275-5-git-send-email-will.deacon@arm.com>
	<AANLkTimiPEsb_S3tv+yPOr=p8UageK_-er9HkjM10ro5@mail.gmail.com>
Message-ID: <001f01cbd372$91f49990$b5ddccb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kyungmin,

> Tested-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> It's boot and working at mainline.

Thanks for testing this.
 
> It's just for record.
> Current mainline codes doesn't have full features of s5pv310 (aka
> s5pc210 or exynos4210).
> So I back-ported the same codes to 2.6.36. it's booted and working at
> boot time, but some times later it's hang.
> no serial. I think as irq cores at arm changed, it requires the more
> patched than just this patch.

Interesting. I backported to v2.6.36 and stress-tested it for a few
hours on my versatile express without any problems. If you diagnose
this further, please let me know.

Will
