From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 15 May 2018 13:05:29 +0300
Subject: [PATCH v4 5/8] PCI: Replace pr_*() with dev_*() in
 of_pci_get_host_bridge_resources()
In-Reply-To: <95f6ca417e2bc74d15f707e577b098e46b4b3ba4.1526375226.git.jan.kiszka@siemens.com>
References: <cover.1526375226.git.jan.kiszka@siemens.com>
 <95f6ca417e2bc74d15f707e577b098e46b4b3ba4.1526375226.git.jan.kiszka@siemens.com>
Message-ID: <f5a8fd42-6de7-8aa2-fdc7-a5d43e3e4d98@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15/2018 12:07 PM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Now that we have a device reference, make use of it for printing.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
