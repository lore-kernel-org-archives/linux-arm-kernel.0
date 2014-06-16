From: ming.lei@canonical.com (Ming Lei)
Date: Mon, 16 Jun 2014 23:59:21 +0800
Subject: [PATCH v2 0/2]ata: Fix the dma state machine lockup for APM
 X-Gene SoC
In-Reply-To: <1402911336-31788-1-git-send-email-stripathi@apm.com>
References: <1402911336-31788-1-git-send-email-stripathi@apm.com>
Message-ID: <CACVXFVPQhwyMN0ynhXkmD+DipmPiSHH2YFN++iwE64o=nghCxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 5:35 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Suman Tripathi (2):
>   libahci: Implement the function ahci_restart_engine to restart the
>     port dma engine.
>   ata: Fix the dma state machine lockup for the IDENTIFY DEVICE PIO mode
>     command.
>
>  drivers/ata/ahci.h       |  4 ++++
>  drivers/ata/ahci_xgene.c | 17 +++--------------
>  drivers/ata/libahci.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+), 14 deletions(-)

V2 looks good and makes my mutang board bootable, thanks.

Reported-and-tested-by: Ming Lei <ming.lei@canonical.com>


Thanks,
--
Ming Lei
