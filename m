From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 21:23:12 +0800
Subject: [PATCH 04/17] ARM: ep93xx: use machine specific hook for late init
In-Reply-To: <4F99CF07.5020006@gmail.com>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-5-git-send-email-shawn.guo@linaro.org>
 <4F99B9EB.6060806@gmail.com>
 <ADE657CA350FB648AAC2C43247A983F002069887EDC4@AUSP01VMBX24.collaborationhost.net>
 <4F99CF07.5020006@gmail.com>
Message-ID: <20120427132310.GC2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 08:41:11AM +1000, Ryan Mallon wrote:
> Hmm, I see. It's a bit annoying that it makes the code less clean, but I
> can't really see any other nice way of doing it :-/.
> 
I guess you will feel the gain if you have more stuff later that need
to get done in late_initcall time, especially when these stuff are soc
specific or even board specific.

-- 
Regards,
Shawn
