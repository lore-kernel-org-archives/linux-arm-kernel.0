From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 16 Jun 2018 15:00:06 +0200
Subject: [PATCH 1/2] drm/rockchip: cnd-dp: adjust spdif register setting
In-Reply-To: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
References: <1526979222-32478-1-git-send-email-hl@rock-chips.com>
Message-ID: <1713657.Ecv5Pr7be3@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 22. Mai 2018, 10:53:41 CEST schrieb Lin Huang:
> We use jitter bypass mode for spdif, so do not need to set jitter mode
> related bit in SPDIF_CTRL_ADDR register. Also, we need to enable
> SPDIF_ENABLE bit.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

applied to drm-misc-next after adapting the commit message
to make it clear that we need to keep the SPDIF_ENABLE bit.


Thanks
Heiko
