From: vinholikatti@gmail.com (vinayak holikatti)
Date: Tue, 27 Nov 2012 17:02:51 +0530
Subject: [PATCH 192/493] scsi: remove use of __devinit
In-Reply-To: <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-192-git-send-email-wfp5p@virginia.edu>
Message-ID: <CAKVbJB9wTj9HtXYTW0Le+oHsdMACkuBnf2jSXu-pAx+gPKoBYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  drivers/scsi/ufs/ufshcd.c                 |  2 +-

Acked-by: Vinayak Holikatti <vinholikatti@gmail.com>

only for drivers/scsi/ufs/ufshcd.c

> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 4a370f8..a79ff87 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -1811,7 +1811,7 @@ static int ufshcd_set_dma_mask(struct ufs_hba *hba)
>   *
>   * Returns 0 on success, non-zero value on failure
>   */
> -static int __devinit
> +static int
>  ufshcd_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
>         struct Scsi_Host *host;


-- 
Regards,
Vinayak Holikatti
