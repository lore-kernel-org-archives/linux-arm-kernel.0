From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 12 Oct 2016 11:00:22 -0500
Subject: [PATCH v2 0/2] PCI: aardvark: Cleanup
In-Reply-To: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20161012160021.GA4308@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 12, 2016 at 07:36:21AM -0500, Bjorn Helgaas wrote:
> Add local "dev" pointers to reduce repetition of things like "&pdev->dev"
> and remove unused drvdata.
> 
> Changes from v1:
>   I dropped the following because they added a lot of churn for
>   questionable benefit:
>     PCI: aardvark: Name private struct pointer "advk" consistently
>     PCI: aardvark: Reorder accessor functions
>     PCI: aardvark: Swap order of advk_write() reg/val arguments
> 
> ---
> 
> Bjorn Helgaas (2):
>       PCI: aardvark: Add local struct device pointers
>       PCI: aardvark: Remove unused platform data

I applied these to pci/host-aardvark for v4.9.  I hope to ask Linus to
pull them tomorrow, so if you see any issues, let me know soon.
