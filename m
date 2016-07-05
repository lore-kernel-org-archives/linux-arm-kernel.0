From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Jul 2016 15:46:41 +0200
Subject: [PATCH] pinctrl: sunxi: fix nand0 function name for sun8i
In-Reply-To: <20160704022931.46223-1-icenowy@aosc.xyz>
References: <20160704022931.46223-1-icenowy@aosc.xyz>
Message-ID: <CACRpkdbp3AENFW8ixHmyCdkpTNH8WMdJtYJ0Wuwbh9NLVrhR_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 4, 2016 at 4:29 AM, Icenowy Zheng <icenowy@aosc.xyz> wrote:

> In sun4/5/6/7i, all the pin function related to NAND0 controller is
> named "nand0". However, in sun8i, some of the functions are named as
> "nand". This patch renamed them to "nand0", for the consistency.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
