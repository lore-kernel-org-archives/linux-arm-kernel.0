From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 16 Jul 2013 00:42:15 -0300
Subject: [PATCH 1/5] ARM: dts: imx23-evk: enable USB PHY and controller
In-Reply-To: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
Message-ID: <CAOMZO5D+szAgY6+CHjwFRw2qwvusv2_Ach0hv=hj4X1cmMnHfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 11:22 AM, Otavio Salvador
<otavio@ossystems.com.br> wrote:
> The i.MX23EVK board provides a USB port so the USB PHY and controller
> need to be enabled for it to be usable.

Has this been tested? I don't see in this patch any code to enable USB power.
