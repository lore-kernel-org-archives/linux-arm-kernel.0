From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 27 Apr 2012 19:34:38 -0600 (MDT)
Subject: [PATCH] ARM: OMAP2+: hwmod: Add new sysc_type3 into omap_hwmod
 required for am33xx
In-Reply-To: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
References: <1329481488-27771-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1204271934230.10308@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Feb 2012, Vaibhav Hiremath wrote:

> In case of AM33xx family of devices (like cpsw) have different sysc
> bit field offsets defined,
> 
> sysc_type3:
> |  3     2  |  1    0  |
> | STDBYMODE | IDLEMODE |
> 
> So introduce new sysc_type3 in omap_hwmod common data.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>

Thanks, queued for 3.5.


- Paul
