From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Sep 2011 12:11:58 -0300
Subject: [PATCH] ARM: mxs: Consolidate mm-mx23.c and mm-mx28.c into a
	single file
In-Reply-To: <20110930151725.GG19807@S2100-06.ap.freescale.net>
References: <1317385328-14529-1-git-send-email-fabio.estevam@freescale.com>
	<20110930151725.GG19807@S2100-06.ap.freescale.net>
Message-ID: <CAOMZO5AKz7Ltv_Lvu4R=adX9LG0WR5Z82=MMyVWth14KnSwArg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2011 at 12:17 PM, Shawn Guo <shawn.guo@freescale.com> wrote:

> Beside reducing one file, the benefit of the consolidation includes
> that we have the chance to consolidate the common pattern between mx23
> and mx28. ?I see mx23_init_irq() and mx28_init_irq() have something in
> common. ?Not sure if you care to consolidate it.

Yes, I can look at it also if this current patch gets accepted.

Regards,

Fabio Estevam
