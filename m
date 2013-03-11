From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 11 Mar 2013 20:59:26 +0530
Subject: [PATCH 04/10] ARM: OMAP2+: Divorce from local timer API
In-Reply-To: <20130308195058.GH11806@atomide.com>
References: <1362614646-24113-1-git-send-email-sboyd@codeaurora.org>
 <1362614646-24113-5-git-send-email-sboyd@codeaurora.org>
 <20130308195058.GH11806@atomide.com>
Message-ID: <513DF856.7070400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 March 2013 01:20 AM, Tony Lindgren wrote:
> * Stephen Boyd <sboyd@codeaurora.org> [130306 16:22]:
>> Now that the TWD doesn't rely on the local timer API, OMAP can
>> stop selecting it in Kconfig and relying on the config option to
>> decide if it should call smp_twd functions.
>>

> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> 

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
