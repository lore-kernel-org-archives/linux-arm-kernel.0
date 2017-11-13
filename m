From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 13 Nov 2017 09:10:09 -0800
Subject: [PATCHv3 2/3] EDAC: ti: add support for TI keystone and DRA7xx
 EDAC
In-Reply-To: <1510578490-14510-1-git-send-email-t-kristo@ti.com>
References: <1510087139-21885-3-git-send-email-t-kristo@ti.com>
 <1510578490-14510-1-git-send-email-t-kristo@ti.com>
Message-ID: <47e1810b-a10b-28fb-ba0e-fe28ae337c61@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2017 5:08 AM, Tero Kristo wrote:
> TI Keystone and DRA7xx SoCs have support for EDAC on DDR3 memory that can
> correct one bit errors and detect two bit errors. Add EDAC driver for this
> feature which plugs into the generic kernel EDAC framework.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
Once you have driver queued up, please post DTS patches
separately. Will queue them up.

Regards,
Santosh
