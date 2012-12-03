From: nvmarkzhang@gmail.com (Mark Zhang)
Date: Mon, 03 Dec 2012 10:48:40 +0800
Subject: [PATCH] ARM: dt: tegra: cardhu: Add drm components
In-Reply-To: <50B908F1.8000407@wwwdotorg.org>
References: <1354254256-10212-1-git-send-email-markz@nvidia.com>
 <50B908F1.8000407@wwwdotorg.org>
Message-ID: <50BC1308.4050407@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/01/2012 03:28 AM, Stephen Warren wrote:
> On 11/29/2012 10:44 PM, Mark Zhang wrote:
>> This patch adds the RGB & HDMI nodes in Tegra 30 cardhu's dts.
>> This makes the LVDS & HDMI working.
> 
> This still doesn't add any of the backlight/panel GPIO programming,
> which I believe is required before we enable any LCDs. We could add the
> HDMI node without that though.

Okay. So I think I may misunderstood your words several days ago, when I
submitted the v1 and v2 version for this patch.

So let's hold on this and wait for the backlight/panel working on cardhu.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
