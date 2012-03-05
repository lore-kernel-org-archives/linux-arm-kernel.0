From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 5 Mar 2012 15:33:47 +0800
Subject: [PATCH 03/20] ARM: imx: merge audmux-v1 and audmux-v2
In-Reply-To: <4F54072E.6040407@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
 <1330788001-10158-4-git-send-email-shawn.guo@linaro.org>
 <4F54072E.6040407@freescale.com>
Message-ID: <20120305073345.GA16232@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 12:22:07AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > +static unsigned char port_mapping[] = {
> > +	0x0, 0x4, 0x8, 0x10, 0x14, 0x1c,
> > +};
> 
> May as well make this a 'const' array while you're at it.  And perhaps 
> uint8_t is a better choice than "unsigned char".
> 
Okay, will do.

-- 
Regards,
Shawn
