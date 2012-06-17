From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 17 Jun 2012 09:41:49 -0300
Subject: [PATCH] ARM: mx23: Add initial support for olinuxino board
In-Reply-To: <201206171314.09561.marex@denx.de>
References: <1339914539-4154-1-git-send-email-festevam@gmail.com>
 <201206171314.09561.marex@denx.de>
Message-ID: <CAOMZO5CrRwduuFVtvHHnP2Vb-XS=VR+rf-RS9ZaeSkWmdUnWQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 8:14 AM, Marek Vasut <marex@denx.de> wrote:

>> ?static const char *imx23_dt_compat[] __initdata = {
>> ? ? ? "fsl,imx23-evk",
>> + ? ? "fsl,imx23-olinuxino",
>
> Is this addition needed?

Actually it is not required. Board boots just fine without it.

I have just kept this for compatibilty with other i.MX boards boards
added to dt.

I followed the same approach from imx6q_dt_compat and imx53_dt_compat.
