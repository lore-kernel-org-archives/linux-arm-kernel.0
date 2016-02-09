From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 09 Feb 2016 18:29:50 +0100
Subject: [PATCH v7 6/9] ARM: dts: add pl330-broken-no-flushp quirk for
 rk3036 SoCs
In-Reply-To: <1453460812-8498-7-git-send-email-wxt@rock-chips.com>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <1453460812-8498-7-git-send-email-wxt@rock-chips.com>
Message-ID: <1488837.V2iXLjBOmC@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. Januar 2016, 19:06:49 schrieb Caesar Wang:
> Pl330 integrated in rk3036 platform that doesn't support
> DMAFLUSHP function. So we add 'arm,pl330-broken-no-flushp' quirk
> for rk3036.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

applied the 3 (4/9, 5/9, 6/9) dts patches to my dts32 branch for 4.6
(after fixing the patch subjects to match the general style-convention)
