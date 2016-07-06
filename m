From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 06 Jul 2016 18:26:10 +0200
Subject: [PATCH 1/3] reset: socfpga: no need to store modrst_offset
In-Reply-To: <577D2C7A.2030204@opensource.altera.com>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
 <577D2C7A.2030204@opensource.altera.com>
Message-ID: <1467822370.2914.14.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 06.07.2016, 11:06 -0500 schrieb Dinh Nguyen:
> On 07/05/2016 05:17 AM, Philipp Zabel wrote:
> > Since we can just add it to membase once, there is no need to store
> > modrst_offset separately, and to repeat the addition with every access.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  drivers/reset/reset-socfpga.c | 19 +++++++++----------
> >  1 file changed, 9 insertions(+), 10 deletions(-)
> > 
> 
> In case you want it:
> 
> Tested-by: Dinh Nguyen <dinguyen@opensource.altera.com>

I'll take it, thank you.

regards
Philipp
