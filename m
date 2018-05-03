From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 3 May 2018 10:15:12 +0300
Subject: [PATCH v2 05/10] PCI: Replace pr_*() with dev_*() in
 __of_pci_get_host_bridge_resources()
In-Reply-To: <63f2e316090ea3284b4be62e446b3b28f998ac55.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <63f2e316090ea3284b4be62e446b3b28f998ac55.1525067324.git.jan.kiszka@siemens.com>
Message-ID: <57fa1919-80ea-df19-49a7-9d2d3e100d2e@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Now that we have a device reference, make use of it for printing. And as
> long as dev can still be NULL, we will still get some reasonable output
> nevertheless.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
