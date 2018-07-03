From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 15:15:44 +0800
Subject: [PATCH] ARM: imx: enable bus auto clock gating function for
 i.mx6sll
In-Reply-To: <20180703062014.GB4242@dell>
References: <1529645568-3786-1-git-send-email-Anson.Huang@nxp.com>
 <20180701085111.GK4348@dragon> <20180703062014.GB4242@dell>
Message-ID: <20180703071542.GN4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 07:20:14AM +0100, Lee Jones wrote:
> On Sun, 01 Jul 2018, Shawn Guo wrote:
> 
> > On Fri, Jun 22, 2018 at 01:32:48PM +0800, Anson Huang wrote:
> > > i.MX6SLL has HW bus auto clock gating function, enable
> > > it by default to save VDD_SOC_IN power, about 5% ~ 20%
> > > saved depends on different use cases.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > Applied, thanks.
> 
> Since this touches MFD, please apply my Ack to the patch.
> 
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Done.  Thanks for reminding, Lee.

> 
> -- 
> Lee Jones [???]

Nice Chinese name, BTW ;)

Shawn
