From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 27 Nov 2014 00:15:58 +0100
Subject: [PATCH] clk: rockchip: rk3288 export i2s0_clkout for use in DT
In-Reply-To: <CAD=FV=W_t813jFgPgkxq7g3Bn5+MHj_t-G7=OP4xFmDnaMjF7w@mail.gmail.com>
References: <1416381319-31117-1-git-send-email-sonnyrao@chromium.org>
 <13759993.X1UzQR0utx@diego>
 <CAD=FV=W_t813jFgPgkxq7g3Bn5+MHj_t-G7=OP4xFmDnaMjF7w@mail.gmail.com>
Message-ID: <1452869.BD3Nj3iYiH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am Mittwoch, 26. November 2014, 15:05:53 schrieb Doug Anderson:
> I'm no longer convinced that's a good idea, so we should just axe the
> CLK_SET_RATE_PARENT.
> 
> If timing is working out well and Sonny isn't available to spin this
> right now (it's Thanksgiving holidays here in the US), I doubt he
> would mind if you fixed up the patch and submitted it.

yep I can do that ... I just wanted some sort of confirmation to verify that 
I'm not missing anything obvious before I start modifying patches :-)


Heiko
