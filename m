From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 25 Sep 2014 09:38:01 +0200
Subject: [PATCH v2 17/22] s390/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
References: <1411614872-4009-1-git-send-email-wangyijing@huawei.com>
 <1411614872-4009-18-git-send-email-wangyijing@huawei.com>
Message-ID: <20140925073800.GM12423@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 25, 2014 at 11:14:27AM +0800, Yijing Wang wrote:
[...]
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
[...]
> @@ -358,7 +358,7 @@ static void zpci_irq_handler(struct airq_struct *airq)
>  	}
>  }
>  
> -int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> +int zpci_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)

static?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140925/7229facf/attachment.sig>
