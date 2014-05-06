From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 06 May 2014 13:44:38 +1000
Subject: [PATCH v3 4/7] of: configure the platform device dma parameters
In-Reply-To: <CAErSpo6gYT34-sOvNgEdV+3wxv=Fdqtx7c1d-4577mFydLtZMg@mail.gmail.com>
References: <1398353407-2345-1-git-send-email-santosh.shilimkar@ti.com>
 <20923376.buVzFR52Qe@wuerfel>
 <CAErSpo5-FXmVs8BWRYKz9Ln1g1Ls7_uo3oiPd32fUegf3d8hXQ@mail.gmail.com>
 <5575019.Hr92MUuDnc@wuerfel>
 <CAErSpo6gYT34-sOvNgEdV+3wxv=Fdqtx7c1d-4577mFydLtZMg@mail.gmail.com>
Message-ID: <1399347878.20388.96.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2014-05-05 at 16:28 -0600, Bjorn Helgaas wrote:
> I still wonder whether arm, powerpc, and tile (and I just noticed
> microblaze also has a similar dma_direct_map_page()) could all be
> handled by attaching devices to a generic trivial IOMMU driver
> parameterized with the appropriate constant offset.

On powerpc, the offset is not constant, it can be per-device

Cheers,
Ben.
