From: s-anna@ti.com (Suman Anna)
Date: Thu, 3 Sep 2015 17:34:15 -0500
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy OMAP3 ISP instantiation
In-Reply-To: <20150716125800.GN17550@atomide.com>
References: <1437051319-9904-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1437051319-9904-2-git-send-email-laurent.pinchart@ideasonboard.com>
 <20150716125800.GN17550@atomide.com>
Message-ID: <55E8CAE7.3010301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On 07/16/2015 07:58 AM, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [150716 05:57]:
>> The OMAP3 ISP is now fully supported in DT, remove its instantiation
>> from C code.
> 
> Please feel to queue this along with the second patch in this series,
> this should not cause any merge conflicts:
> 
> Acked-by: Tony Lindgren <tony@atomide.com>

Just wondering if you have already queued this, I see the v4l changes in
linux-next, but not this patch. Also, can you confirm if this series is
making it into 4.3?

regards
Suman
