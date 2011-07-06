From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 6 Jul 2011 13:53:32 +0800
Subject: [PATCH v2 1/2] serial/imx: get rid of the uses of cpu_is_mx1()
In-Reply-To: <CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
References: <1309878338-25697-1-git-send-email-shawn.guo@linaro.org>
	<1309878338-25697-2-git-send-email-shawn.guo@linaro.org>
	<CACxGe6v+izZiANbzvhnTvrLU9+XgXD=W8FNGfTLzGXLNuCjZcg@mail.gmail.com>
Message-ID: <20110706055331.GD26324@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 11:27:55AM -0600, Grant Likely wrote:
> On Tue, Jul 5, 2011 at 9:05 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > The patch removes all the uses of cpu_is_mx1(). ?Instead, it uses
> > the .id_table of platform_driver to distinguish the uart device type.
> >
> > A couple of !cpu_is_mx1() logic gets turned into IS_IMX_UART, as the
> > codes wrapped there are really IMX specific.
> >
> > It also removes macro MX1_UCR3_REF25 and MX1_UCR3_REF30 which are
> > not used anywhere.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Who's tree is this one going to get merged through?
> 
I think it will be easier to go Sascha's tree.  Alan, Sascha, what
do you think?

-- 
Regards,
Shawn
