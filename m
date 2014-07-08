From: fabf@skynet.be (Fabian Frederick)
Date: Tue, 8 Jul 2014 07:08:08 +0200
Subject: [PATCH 1/1] ARM: imx: use PTR_ERR_OR_ZERO
In-Reply-To: <CAK5sBcE2xxb1NGegn1L_CFH27vzx8kLg06u9fVTo6SZk8_6qJQ@mail.gmail.com>
References: <1404500590-21712-1-git-send-email-fabf@skynet.be>
 <20140707055521.GM30239@dragon>
 <CAK5sBcE2xxb1NGegn1L_CFH27vzx8kLg06u9fVTo6SZk8_6qJQ@mail.gmail.com>
Message-ID: <20140708070808.07c7f690e82c9bcf822f772e@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Jul 2014 09:18:56 +0530
Sachin Kamat <spk.linux@gmail.com> wrote:

> Hi Shawn,
> 
> On Mon, Jul 7, 2014 at 11:25 AM, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Fri, Jul 04, 2014 at 09:03:10PM +0200, Fabian Frederick wrote:
> >> replace IS_ERR/PTR_ERR
> >>
> >> Cc: Shawn Guo <shawn.guo@freescale.com>
> >> Cc: Sascha Hauer <kernel@pengutronix.de>
> >> Cc: linux-arm-kernel at lists.infradead.org
> >> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> >
> > Applied, thanks.
> 
> 
> I had sent a similar series [1] in May which you rejected. Just
> curious if something
> changed between then and now?

Hi Sachin,

	I still don't see anything from you for those files in linux-next lately.
If it was already in some other tree, you can remove my patch or update signed-off-by as it seems
you made it before me :)
 
Regards,
Fabian

> 
> [1] http://patchwork.ozlabs.org/patch/353653/
> 
> -- 
> Regards,
> Sachin.
