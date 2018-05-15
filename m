From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 15 May 2018 13:05:13 +0300
Subject: [PATCH v4 4/8] PCI: Replace dev_node parameter of
 of_pci_get_host_bridge_resources with device
In-Reply-To: <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <5f2226585c6af9920b266d0503e32042d4c9e440.1526375226.git.jan.kiszka@siemens.com>
Message-ID: <6bbbb011-7cae-80a3-4cce-6608b4aace2c@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2018 12:07 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Another step towards a managed version of
> of_pci_get_host_bridge_resources(): Feed in the underlying device,
> rather than just the OF node. This will allow to use managed resource
> allocation internally later on.
> 
> CC: Jingoo Han <jingoohan1@gmail.com>
> CC: Joao Pinto <Joao.Pinto@synopsys.com>
> CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
