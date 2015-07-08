From: davem@davemloft.net (David Miller)
Date: Wed, 08 Jul 2015 14:44:57 -0700 (PDT)
Subject: [PATCH net-next] drivers: net: xgene: Fix the compilation
 error "error: implicit declaration of function 'acpi_evaluate_integer'"
 for CONFIG_ACPI=n.
In-Reply-To: <1436169862-1372-1-git-send-email-stripathi@apm.com>
References: <1436169862-1372-1-git-send-email-stripathi@apm.com>
Message-ID: <20150708.144457.1671326667513366241.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suman Tripathi <stripathi@apm.com>
Date: Mon,  6 Jul 2015 13:34:22 +0530

> This patch guards the acpi_evaluate_interger function as it fails
> the build for CONFIG_ACPI=n.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>

While the net-next tree is closed, all work and bug fixes should occur against
'net' which trumps the 'net-next' tree during this time.

If you had investigated, you would have seen that this build failure had
been fixed in the 'net' tree for some time now.
