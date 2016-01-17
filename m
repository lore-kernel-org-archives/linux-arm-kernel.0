From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 17 Jan 2016 20:20:48 +0100
Subject: [PATCH v3 9/9] ARM: dts: rockchip: add pl330-broken-no-flushp
 quirk for rk3036 SoCs
In-Reply-To: <1452865796-23527-10-git-send-email-wxt@rock-chips.com>
References: <1452865796-23527-1-git-send-email-wxt@rock-chips.com>
 <1452865796-23527-10-git-send-email-wxt@rock-chips.com>
Message-ID: <2986016.zV0HQZEBmn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar,

Am Freitag, 15. Januar 2016, 21:49:56 schrieb Caesar Wang:
> Pl330 integrated in rk3036 platform that doesn't support
> DMAFLUSHP function. So we add 'arm,pl330-broken-no-flushp' quirk
> for rk3036.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

can you try to find out if Shawn plans on respinning his work on the pl330 
quirk that is needed for this. His last submission seems to be from october.


Thanks
Heiko
