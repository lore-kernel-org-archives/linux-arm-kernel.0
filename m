From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 22 Oct 2015 17:13:55 -0500
Subject: [PATCH v11 2/6] pci: add Altera PCI vendor ID
In-Reply-To: <1445506051-21688-3-git-send-email-lftan@altera.com>
References: <1445506051-21688-1-git-send-email-lftan@altera.com>
 <1445506051-21688-3-git-send-email-lftan@altera.com>
Message-ID: <20151022221355.GJ21237@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 05:27:27PM +0800, Ley Foon Tan wrote:
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index d9ba49c..08e4462 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1550,6 +1550,8 @@
>  #define PCI_DEVICE_ID_SERVERWORKS_CSB6LPC 0x0227
>  #define PCI_DEVICE_ID_SERVERWORKS_HT1100LD 0x0408
>  
> +#define PCI_VENDOR_ID_ALTERA		0x1172
> +

This doesn't seem to be used anywhere, so I'll drop this patch.

>  #define PCI_VENDOR_ID_SBE		0x1176
>  #define PCI_DEVICE_ID_SBE_WANXL100	0x0301
>  #define PCI_DEVICE_ID_SBE_WANXL200	0x0302
> -- 
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
