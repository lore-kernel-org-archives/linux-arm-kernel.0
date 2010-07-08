From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 8 Jul 2010 23:13:52 +0300
Subject: [PATCH 15/15] omap: zoom: enable WLAN device
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C9B7@dbde02.ent.ti.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-16-git-send-email-ohad@wizery.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030E10C9B7@dbde02.ent.ti.com>
Message-ID: <AANLkTikAq9wgsfxP7LMObEMuaNM9YjhDfk9MzK8tLoXs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 8, 2010 at 6:39 AM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
> [Ghorai] In general we can avoid OMAP_ZOOM_WLAN and MMC_EMBEDDED_SDIO as kconfig option. 1st one is board specific and 2nd one could be generic sdio code. As I mentioned in other patch too.


Thanks, will get rid of the extra config options.


>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
