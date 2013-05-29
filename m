From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 16:17:31 +0200
Subject: [PATCH V3 1/3] mmc: Add size for caller in init+register
In-Reply-To: <1369790016-13270-1-git-send-email-csd@broadcom.com>
References: <1369790016-13270-1-git-send-email-csd@broadcom.com>
Message-ID: <201305291617.31983.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Christian Daudt wrote:
> Add a param to allow users of sdhci_pltfm to allocate private space
> in calls to sdhci_pltfm_init+sdhci_pltfm_register. This is implemented
> in the same way as sdhci does for its users.
>  None of the users have been migrated yet and are passing in zero to
> retain their private allocation.
> 
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
> 
> Also removed unused variable in sdhci_pltfm_init fn
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
