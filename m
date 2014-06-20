From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 20 Jun 2014 11:59:01 +0800
Subject: [PATCH v3 0/2]]ata: Fix the dma state machine lockup for APM
 X-Gene SoC
In-Reply-To: <1403160538-31565-1-git-send-email-stripathi@apm.com>
References: <1403160538-31565-1-git-send-email-stripathi@apm.com>
Message-ID: <CACVXFVPqhVSoxQQi4kS2+_Xmn9xAFcbRSpvoxU-yGJkxM7FUtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suman,

On Thu, Jun 19, 2014 at 2:48 PM, Suman Tripathi <stripathi@apm.com> wrote:
> Signed-off-by: Loc Ho <lho@apm.com>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
> Suman Tripathi (2):
>   libahci: Implement the function ahci_restart_engine to restart the
>     port dma engine.
>   ata: Fix the dma state machine lockup for the IDENTIFY DEVICE PIO mode
>     command.
>
>  drivers/ata/ahci.h       |  2 ++
>  drivers/ata/ahci_xgene.c | 70 +++++++++++++++++++++++++++++++++++++++---------
>  drivers/ata/libahci.c    | 15 ++++++++++-
>  3 files changed, 73 insertions(+), 14 deletions(-)

These two patches does fix boot failure on our mustang board, thanks
Suman!

Reported-and-Tested-by: Ming Lei <ming.lei@canonical.com>

Thanks,
-- 
Ming Lei
