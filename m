From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 3 May 2018 10:14:06 +0300
Subject: [PATCH v2 03/10] PCI: Factor out
 __of_pci_get_host_bridge_resources()
In-Reply-To: <35efe707d03c886f1ac1e0c9634810c9da59c88a.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <35efe707d03c886f1ac1e0c9634810c9da59c88a.1525067324.git.jan.kiszka@siemens.com>
Message-ID: <63e44c62-df98-0e73-5981-fdf2094e2fb2@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> This will be needed for sharing the core logic between current
> of_pci_get_host_bridge_resources() and upcoming
> devm_of_pci_get_host_bridge_resources().
> 
> Already rename the dev parameter to dev_node in order to free the
> namespace for a real device parameter.
> 
> No functional changes.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
