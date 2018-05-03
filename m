From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Thu, 3 May 2018 10:14:20 +0300
Subject: [PATCH v2 04/10] PCI: Add dev parameter to
 __of_pci_get_host_bridge_resources()
In-Reply-To: <cfab525f3d0436f75187fbd65907ada909d7692f.1525067324.git.jan.kiszka@siemens.com>
References: <cover.1525067324.git.jan.kiszka@siemens.com>
 <cfab525f3d0436f75187fbd65907ada909d7692f.1525067324.git.jan.kiszka@siemens.com>
Message-ID: <e06087fd-3258-89d4-cdc3-06196bd61dbe@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2018 08:48 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> When non-NULL, use the new dev parameter of
> __of_pci_get_host_bridge_resources() to allocate the resource data
> structures via devm_kzalloc. That allows to release them automatically
> during device destruction.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Tested-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

--
With best wishes,
Vladimir
