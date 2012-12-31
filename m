From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 31 Dec 2012 12:56:02 +0000 (UTC)
Subject: [PATCH 2/3] ARM: OMAP2+: hwmod: add support for blocking WFI
 when a device is active
In-Reply-To: <50E14C12.5020105@ti.com>
References: <20121230182745.30526.47072.stgit@dusk.lan>
 <20121230182829.30526.32914.stgit@dusk.lan> <50E14C12.5020105@ti.com>
Message-ID: <alpine.DEB.2.00.1212311254570.27120@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, 31 Dec 2012, Santosh Shilimkar wrote:

> This is more of question. If the limitation is w.r.t MPU power
> state then shouldn't we just prevent the MPU power state rather
> than blocking the WFI completely.
> 
> Can you please clarify if retaining MPU power state in ON can achieve
> the same results ?

In these cases, it's blocking WFI that is apparently needed.  I know it 
doesn't make much sense.


- Paul
