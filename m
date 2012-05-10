From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 10 May 2012 15:19:08 +0530
Subject: [PATCH 02/13] ARM: OMAP5: Add minimal support for OMAP5430 SOC
In-Reply-To: <20120509160042.GM5088@atomide.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
 <1336029982-31898-3-git-send-email-r.sricharan@ti.com>
 <20120504223933.GX5613@atomide.com>
 <CAJ7qFSfkHGF7ehanZP=hyZ27HqSp1ONsT0tUV-wpLne9B4DEaQ@mail.gmail.com>
 <20120507173351.GB5088@atomide.com>
 <CAJ7qFSeziNRTUsUWc2Owjqs=A99p_WgiVH8vnEBoVB42v2p+pQ@mail.gmail.com>
 <20120509160042.GM5088@atomide.com>
Message-ID: <CAJ7qFSfnVAHE1jX0UcBcJU0JQPeNjKfgq_tj_yvf=BL0fN4jdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,
[snip]
>> ?So after the cleanup patch introducing CONFIG_SOC_OMAP4PLUS
>> ?it can be changed as
>> ?#ifdef (CONFIG_SOC_OMAP4PLUS) && !(defined(CONFIG_ARCH_OMAP2) ||
>> defined(CONFIG_ARCH_OMAP3))
>>
>> So this will avoid patching this for the future socs. ?
>
> Well it seems that we've come to a conclusion that if we introduce
> new config options, they should be based on features instead. So
> CONFIG_SOC_HAS_OMAPXYZ_BLAH rather than CONFIG_SOC_OMAP4PLUS.
>
   Sure thanks for clarifying.
  Then i will introduce  a relevant config in my cleanup patch first and
  then add OMAP5.

Thanks,
 Sricharan
