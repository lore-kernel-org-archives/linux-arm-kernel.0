From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Wed, 8 Aug 2018 10:53:52 +0000
Subject: [PATCH v3 0/2] PCI: imx: Initial imx7d pm support
In-Reply-To: <cover.1532448745.git.leonard.crestez@nxp.com>
References: <cover.1532448745.git.leonard.crestez@nxp.com>
Message-ID: <bac2cb70b16d81f589915fc0900126b516414243.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-24 at 19:14 +0300, Leonard Crestez wrote:
> Changes since v2:
>  * Print with dev_info if link fails on resume (Lucas)
>  * Add a comment on imx7d pci irq mappings (Andrey)
>  * Make imx6_pcie_ltssm_disable print an error on IMX6Q (Lucas)
> 
> The ltssm_disable does not return an error because it can't be usefully
> handled, reversing partial suspend is a nightmare and unlikely to work.
> 
>  * Drop "reset: imx7: Fix always writing bits as 0 (accepted by Philipp)
> 
> Series is against linux-next tag next-20180724 where the reset patch was
> already accepted. The imx7d.dtsi patch is also useful standalone.
> 
> Link to v2: https://lkml.org/lkml/2018/7/20/472

This is a gentle reminder that this series was reviewed by Lucas two
weeks ago but not yet included.

--
Regards,
Leonard
