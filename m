From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 3 Sep 2018 10:31:31 +0200
Subject: [PATCH v4 00/13] ata: ahci_platform: support allwinner R40 AHCI
In-Reply-To: <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <f5838eae-fa6c-8699-14a4-95d0daa8a960@kernel.dk>
 <CAGb2v67miUjqeKeDh_E_XPee_0Hq1C6YrfXxsOp_=NtQY+LLmQ@mail.gmail.com>
 <8fa866c5-6800-505f-53bc-5c1b27582ca6@kernel.dk>
 <20180831074024.w7yicj5y4imy57e2@flea>
 <39f89b9d-f5bf-7c4a-8e68-252bfc0b91a4@kernel.dk>
Message-ID: <20180903083131.asgh6wp54e2fs62l@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 08:35:23AM -0600, Jens Axboe wrote:
> On 8/31/18 1:40 AM, Maxime Ripard wrote:
> > Hi Jens,
11;rgb:0000/2b2b/3636> > 
> > On Thu, Aug 30, 2018 at 08:52:52PM -0600, Jens Axboe wrote:
> >> On 8/30/18 8:32 PM, Chen-Yu Tsai wrote:
> >>> Hi,
> >>>
> >>> On Fri, Aug 31, 2018 at 4:31 AM Jens Axboe <axboe@kernel.dk> wrote:
> >>>>
> >>>> On 8/30/18 1:01 PM, Corentin Labbe wrote:
> >>>>> Hello
> >>>>>
> >>>>> This patchset add support for allwinner R40 AHCI controller.
> >>>>>
> >>>>> The whole patchset is tested on sun8i-r40-bananapi-m2-ultra and
> >>>>> on sun7i-a20-cubieboard2 which doesnt have any of the ressources added
> >>>>> by this serie, so no regression should come with it.
> >>>>>
> >>>>> The last patch(ata: ahci_sunxi: remove PHY code) should not be merged,
> >>>>> but will be resent for inclustion when all patchs will have hit linus
> >>>>> tree.
> >>>>
> >>>> Applied 1-12 with Hans's blessing, thanks Corentin.
> >>>
> >>> Please don't merge device tree ("dts") patches, i.e. patches 9-12. We will
> >>> merge them through the sunxi / armsoc tree. Having them in separate trees
> >>> introduces conflicts when we have other stuff going through our tree.
> >>
> >> OK, fair enough, I can drop those.
> > 
> > And the DT bits actually have some issues that would need to change
> > the code significantly.
> > 
> > Can you drop all of them please?
> 
> OK, can do.

Thanks!

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180903/d7b82e28/attachment.sig>
