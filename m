From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 19 Dec 2011 09:20:34 -0800
Subject: [GIT PULL] imx: gpio interrupt cleanup
In-Reply-To: <20111208143204.GA8139@S2100-06.ap.freescale.net>
References: <20111208143204.GA8139@S2100-06.ap.freescale.net>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF176BE92A13@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Behalf Of Shawn Guo wrote at Thursday, December 08, 2011 7:32 AM:
> Hi Arnd and  Olof,
> 
> Please consider to pull the series below.  I really should have
> Thomas' ack on Jamie's patch 'irqdomain: export irq_domain_simple_ops
> for !CONFIG_OF', and Grant's ack on patch 'gpio/mxc: adopt irq_domain
> in gpio driver'.  So this pull request is also asking comments for the
> path of these patches.
> 
> Thomas, Grant,
> 
> Please speak up if you do not want "your" patches to go through arm-soc
> tree.  Thanks.

Thomas,

I'm waiting on the following patch, since I need it to complete a patch
I'm working on:

> Jamie Iles (1):
>       irqdomain: export irq_domain_simple_ops for !CONFIG_OF

Can you ack it for inclusion in the arm-soc tree, or apply it, so I know
it's OK to rely on this patch in my work?

Thanks.

-- 
nvpublic
