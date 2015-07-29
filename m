From: olof@lixom.net (Olof Johansson)
Date: Wed, 29 Jul 2015 22:10:14 +0200
Subject: [PATCH v2] PCI: iproc: Fix BCMA dependency in Kconfig
In-Reply-To: <1438189973-5712-1-git-send-email-rjui@broadcom.com>
References: <1438189973-5712-1-git-send-email-rjui@broadcom.com>
Message-ID: <20150729201014.GA28206@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 10:12:53AM -0700, Ray Jui wrote:
> The current iProc BCMA front-end driver can only work on ARM32 based
> platforms; therefore its config option in Kconfig should be changed to
> reflect that. This fixes arm64 allmodconfig build failure when compiling
> the the iProc BCMA driver that contains struct pci_sys_data that is
> arm32 specific
> 
> Signed-off-by: Ray Jui <rjui@broadcom.com>

Applied to next/arm64 together with the original series.


-Olof
