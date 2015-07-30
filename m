From: davem@davemloft.net (David Miller)
Date: Wed, 29 Jul 2015 17:18:07 -0700 (PDT)
Subject: [PATCH v2 0/3] Add MDIO support to ThunderX NIC driver
In-Reply-To: <1438121533-21528-1-git-send-email-mohun106@gmail.com>
References: <1438121533-21528-1-git-send-email-mohun106@gmail.com>
Message-ID: <20150729.171807.2080139287211431874.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: mohun106@gmail.com
Date: Tue, 28 Jul 2015 15:12:10 -0700

> This patch series adds MDIO support to ThunderX NIC driver by making use
> of existing mdio-octeon driver. In the process modified the mdio-octeon
> driver to work on both Octeon and ThunderX platforms.
> 
> * From v1:
>   - Removed default selection in Kconfig for MDIO_OCTEON
>   - Replace uint64 with u64 as suggested by David Daney

Series applied, thanks.
