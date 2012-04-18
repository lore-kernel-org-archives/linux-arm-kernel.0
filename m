From: wd@denx.de (Wolfgang Denk)
Date: Wed, 18 Apr 2012 09:27:26 +0200
Subject: [PATCH] i.MX28: Shut down the LCD controller to avoid bootrom
 sampling bug
In-Reply-To: <1334695011-8188-1-git-send-email-marex@denx.de>
References: <1334695011-8188-1-git-send-email-marex@denx.de>
Message-ID: <20120418072726.A431D200229@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek,

In message <1334695011-8188-1-git-send-email-marex@denx.de> you wrote:
> From: Marek Vasut <marek.vasut@gmail.com>
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Lin Tony-B19295 <B19295@freescale.com>
> Cc: Linux FBDEV <linux-fbdev@vger.kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Tony Lin <tony.lin@freescale.com>
> Cc: Wolfgang Denk <wd@denx.de>
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
>  drivers/video/mxsfb.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

Acked-by: Wolfgang Denk <wd@denx.de>
Tested-by: Wolfgang Denk <wd@denx.de>


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
A dog always bit deepest on the veterinary hand.
                                    - Terry Pratchett, _Wyrd Sisters_
