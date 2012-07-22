From: davem@davemloft.net (David Miller)
Date: Sun, 22 Jul 2012 12:46:57 -0700 (PDT)
Subject: [PATCH v3 0/2] net: ethernet: davinci_emac: fixups + pm_runtime
In-Reply-To: <1342833562-3435-1-git-send-email-mgreer@animalcreek.com>
References: <1342833562-3435-1-git-send-email-mgreer@animalcreek.com>
Message-ID: <20120722.124657.1259861132979869204.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Fri, 20 Jul 2012 18:19:20 -0700

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> This series fixes a compile error in, and adds pm_runtime support
> to, the davinci_emac driver.
> 
> To test on a davinci platform, you will need another patch just
> submitted to netdev:
> 
> 	http://marc.info/?l=linux-netdev&m=134282758408187&w=2
> 
> Mark A. Greer (2):
>   net: ethernet: davinci_emac: Remove unnecessary #include
>   net: ethernet: davinci_emac: add pm_runtime support

All applied to net-next, thanks.
