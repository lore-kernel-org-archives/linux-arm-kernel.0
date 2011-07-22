From: jbarnes@virtuousgeek.org (Jesse Barnes)
Date: Fri, 22 Jul 2011 08:53:05 -0700
Subject: [PATCH 4/6] ARM: pci: make pcibios_assign_all_busses use
	pci_has_flag
In-Reply-To: <1310489612-8625-5-git-send-email-robherring2@gmail.com>
References: <1310489612-8625-1-git-send-email-robherring2@gmail.com>
	<1310489612-8625-5-git-send-email-robherring2@gmail.com>
Message-ID: <20110722085305.2f5b6160@jbarnes-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 12 Jul 2011 11:53:30 -0500
Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Convert pcibios_assign_all_busses from a define to inline so platforms can
> control this setting.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks fine to me.  Assuming it's not already upstream... :)

Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>

-- 
Jesse Barnes, Intel Open Source Technology Center
