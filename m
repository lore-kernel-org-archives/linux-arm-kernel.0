From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Jun 2013 10:00:31 +0100
Subject: [PATCH v2 2/3] iommu: add support for ARM Ltd. System MMU
 architecture
In-Reply-To: <20130625212521.GP2743@alberich>
References: <1372095086-15681-1-git-send-email-will.deacon@arm.com>
 <1372095086-15681-3-git-send-email-will.deacon@arm.com>
 <20130625212521.GP2743@alberich>
Message-ID: <20130626090030.GA26142@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 10:25:21PM +0100, Andreas Herrmann wrote:
> On Mon, Jun 24, 2013 at 01:31:25PM -0400, Will Deacon wrote:
> > This patch adds support for SMMUs implementing the ARM System MMU
> > architecture versions 1 or 2. Both arm and arm64 are supported, although
> > the v7s descriptor format is not used.
> >
> > Cc: Rob Herring <robherring2@gmail.com>
> > Cc: Andreas Herrmann <andreas.herrmann@calxeda.com>
> > Cc: Olav Haugan <ohaugan@codeaurora.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Andreas Herrmann <andreas.herrmann@calxeda.com>

Thanks Andreas!

Will
