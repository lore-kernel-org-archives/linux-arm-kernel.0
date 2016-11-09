From: tj@kernel.org (Tejun Heo)
Date: Wed, 9 Nov 2016 11:45:31 -0500
Subject: [PATCH] ata: xgene: Enable NCQ support for APM X-Gene SATA
 controller hardware v1.1
In-Reply-To: <CAFd313x-mXpy0N3aKx2rfoag1FNOrN-LzKb5UHkY2L+GGc0B-A@mail.gmail.com>
References: <1469524857-3720-1-git-send-email-rsahu@apm.com>
 <CAFd313x-mXpy0N3aKx2rfoag1FNOrN-LzKb5UHkY2L+GGc0B-A@mail.gmail.com>
Message-ID: <20161109164531.GA14630@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wed, Sep 14, 2016 at 04:15:00PM +0530, Rameshwar Sahu wrote:
> > @@ -821,8 +823,6 @@ static int xgene_ahci_probe(struct platform_device
> > *pdev)
> >                                 dev_warn(&pdev->dev, "%s: Error reading
> > device info. Assume version1\n",
> >                                         __func__);
> >                                 version = XGENE_AHCI_V1;
> > -                       } else if (info->valid & ACPI_VALID_CID) {
> > -                               version = XGENE_AHCI_V2;

Can you please explain this part a bit?  Everything else looks good to
me.

Thanks.

-- 
tejun
