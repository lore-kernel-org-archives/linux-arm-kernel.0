From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 31 May 2012 16:28:51 -0700
Subject: [PATCH 1/3] ARM: OMAP3+: PM: VP: ensure VP is idle before disable
In-Reply-To: <874nqwx7gt.fsf@ti.com>
References: <1337369601-14915-1-git-send-email-nm@ti.com>
 <1337369601-14915-2-git-send-email-nm@ti.com> <874nqwx7gt.fsf@ti.com>
Message-ID: <4FC7FEB3.3090107@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2012 04:21 PM, Kevin Hilman wrote:
>> diff --git a/arch/arm/mach-omap2/vp.h b/arch/arm/mach-omap2/vp.h
>> >  index 7c155d2..0abf895 100644
>> >  --- a/arch/arm/mach-omap2/vp.h
>> >  +++ b/arch/arm/mach-omap2/vp.h
>> >  @@ -31,7 +31,7 @@ struct voltagedomain;
>> >    #define OMAP4_VP_VDD_MPU_ID 2
>> >
>> >    /* XXX document */
>> >  -#define VP_IDLE_TIMEOUT		200
>> >  +#define VP_IDLE_TIMEOUT		500
> Were you planning to insert the comment here as suggested by Eduardo?

Oops, ignore this comment.  I see you posted a v3 with this added.

Sorry,

Kevin
