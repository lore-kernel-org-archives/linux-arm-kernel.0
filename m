From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Tue, 15 May 2018 10:58:03 +0300
Subject: [PATCH v3 0/8] PCI: leak fixes, removable generic PCI host,
 assorted stuff
In-Reply-To: <cover.1526363896.git.jan.kiszka@siemens.com>
References: <cover.1526363896.git.jan.kiszka@siemens.com>
Message-ID: <72f23e5f-4641-9ef3-09e6-70c4724f21a4@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On 05/15/2018 08:58 AM, Jan Kiszka wrote:
> Changes in v3:
>  - refactor series to be both bisectable and simpler while reworking
>    of_pci_get_host_bridge_resources()
>  - include of_pci_get_host_bridge_resources() removal
>  - include devm_of_pci_get_host_bridge_resources() error path fixes
>  - effectively, no functional changes to v2

while the previous version of the changeset plus the fixup found on Bjorn's
pci/resource branch is sufficient, I can't argue with the fact that this
series is way better.

In case if this series is accepted I'll review and test the fix of
of_pci_get_host_bridge_resources() memleak again, no worries.

--
With best wishes,
Vladimir
