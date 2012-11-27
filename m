From: vinholikatti@gmail.com (vinayak holikatti)
Date: Tue, 27 Nov 2012 12:43:19 +0530
Subject: [PATCH 097/493] scsi: remove use of __devexit_p
In-Reply-To: <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-97-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAKVbJB9MNYU+Q0kkmLnORQyb6=Ua6JesWqaA+pMm98kE2RXswA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  drivers/scsi/ufs/ufshcd.c                 | 2 +-

Acked-by: Vinayak Holikatti <vinholikatti@gmail.com>

only for drivers/scsi/ufs/ufshcd.c

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 58f4ba6..4a370f8 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1947,7 +1947,7 @@ static struct pci_driver ufshcd_pci_driver = {
>         .name = UFSHCD,
>         .id_table = ufshcd_pci_tbl,
>         .probe = ufshcd_probe,
> -       .remove = __devexit_p(ufshcd_remove),
> +       .remove = ufshcd_remove,
>         .shutdown = ufshcd_shutdown,
>  #ifdef CONFIG_PM
>         .suspend = ufshcd_suspend,

Thanks,
Vinayak Holikatti
