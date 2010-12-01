From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Dec 2010 10:33:57 -0800
Subject: [PATCH v8 00/11] OMAP: GPIO: Implement GPIO as platform device
In-Reply-To: <1290689318-10191-1-git-send-email-charu@ti.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
Message-ID: <20101201183357.GI17222@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Varadarajan, Charulatha <charu@ti.com> [101125 04:39]:
> Implement OMAP GPIO module in platform device model. OMAP2+ specific GPIO
> module uses hwmod FW.
> 
> Tested on OMAP2430, OMAP4430, OMAP3430 SDP boards, OMAP4430 Blaze board
> and zoom3 board. Verified that this patch series does not break the OMAP1
> build.

I've boot tested this on N800 + 5912OSK.

I'll apply these patches into devel-gpio branch and start merging these
into linux-omap master branch and into for-next for the next merge window.

I've also added one minor fix for 16xx, will post that separately.

Regards,

Tony
