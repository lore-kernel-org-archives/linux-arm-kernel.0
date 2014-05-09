From: archit@ti.com (Archit Taneja)
Date: Fri, 9 May 2014 11:49:43 +0530
Subject: [PATCH] ARM: OMAP5: DSS hwmod data
In-Reply-To: <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
References: <1394619996-3525-1-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1405080432570.23579@utopia.booyaka.com>
 <536B1A9C.7050006@ti.com>
 <alpine.DEB.2.02.1405081558570.23579@utopia.booyaka.com>
Message-ID: <536C737F.80205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thursday 08 May 2014 09:31 PM, Paul Walmsley wrote:
<snip>

>> The problem is that we have multiple hwmods which use the same MODULEMODE bit.
>> There is no use-counting done when it comes to enabling/disabling modulemode.
>> If there was such a thing, we could have provided MODULEMODE flags even for
>> the children hwmods.
>
> Thanks for the summary.  This is indeed a long-overdue item for the hwmod
> core code.  Can you please patch the hwmod core code to add this?  I'd
> suggest making the use-counting functionality conditional on a hwmod flag
> that you can set for all of the DSS hwmods.  (Ideally, the core code would
> detect that several modules share the same MODULEMODE bits, and
> automatically set it for those cases, but that seems a bit too complex for
> a first cut.)

Sure, I can work on this.

Archit
