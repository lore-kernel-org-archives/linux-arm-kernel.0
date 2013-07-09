From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jul 2013 08:48:37 +0100
Subject: [PATCH v2 2/3] iommu: add support for ARM Ltd. System MMU
 architecture
In-Reply-To: <51DAEA0F.2030808@codeaurora.org>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
 <1372095086-15681-3-git-send-email-will.deacon@arm.com>
 <51DAEA0F.2030808@codeaurora.org>
Message-ID: <20130709074837.GB25885@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 05:34:23PM +0100, Olav Haugan wrote:
> On 6/24/2013 10:31 AM, Will Deacon wrote:
> > This patch adds support for SMMUs implementing the ARM System MMU
> > architecture versions 1 or 2. Both arm and arm64 are supported, although
> > the v7s descriptor format is not used.
> > 
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > Cc: Olav Haugan <ohaugan@codeaurora.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> > ---
> > +/* Maximum number of stream IDs assigned to a single device */
> > +#define MAX_MASTER_STREAMIDS		8
> > +
> 
> Hi Will,

Hi Olav,

> We have designs that require more than 8 Stream IDs. Instead of hard
> coding it to max of 8 can you make this dynamic?

Sure, we can change this if necessary. Care to send a patch? ;)

Will
