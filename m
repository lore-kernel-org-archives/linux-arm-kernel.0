From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 13 Jun 2014 16:20:14 +0800
Subject: [PATCH v1 0/2]ata: Fix the dma state machine lockup for APM
 X-Gene SoC
In-Reply-To: <1402574362-24986-1-git-send-email-stripathi@apm.com>
References: <1402574362-24986-1-git-send-email-stripathi@apm.com>
Message-ID: <CACVXFVMTfNtBe3FXNuo-UqzY5fx+CpGhSCBOspM9G6By8Oi4RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, Jun 12, 2014 at 7:59 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Suman Tripathi (2):
>   libahci: Implement the function ahci_restart_engine to restart the
>     port dma engine.
>   ata: Fix the dma state machine lockup for the PIO mode commands.
>
>  drivers/ata/ahci.h       |  3 +++
>  drivers/ata/ahci_xgene.c | 17 +++--------------
>  drivers/ata/libahci.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 14 deletions(-)

Looks the patch doesn't fix the issue of booting hang on my
mustang board.

And the ata failure message still can be seen.


Thanks,
--
Ming Lei
