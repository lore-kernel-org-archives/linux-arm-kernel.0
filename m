From: yoshihiro.shimoda.uh@renesas.com (Yoshihiro Shimoda)
Date: Tue, 6 Dec 2016 01:35:17 +0000
Subject: [PATCH 01/12] phy: rcar-gen3-usb2: Replace the deprecated extcon
 API
In-Reply-To: <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
 <1480485460-2663-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <HK2PR06MB05489F8F613E9FEE6B9D262CD8820@HK2PR06MB0548.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> From: Chanwoo Choi
> Sent: Wednesday, November 30, 2016 2:57 PM
> 
> This patch replaces the deprecated extcon API as following:
> - extcon_set_cable_state_() -> extcon_set_state_sync()
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Thank you for the patch!

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda
