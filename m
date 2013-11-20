From: lho@apm.com (Loc Ho)
Date: Wed, 20 Nov 2013 11:16:30 -0800
Subject: [PATCH v2 3/4] ata: add APM X-Gene SoC 6.0Gbps SATA PHY driver
In-Reply-To: <CACVXFVPnRCtaFULYf307gfu4jvYpV7cgFOjmq5fOgyfb0Gp+SA@mail.gmail.com>
References: <1384905197-3566-1-git-send-email-lho@apm.com>
 <1384905197-3566-2-git-send-email-lho@apm.com>
 <1384905197-3566-3-git-send-email-lho@apm.com>
 <1384905197-3566-4-git-send-email-lho@apm.com>
 <CACVXFVPnRCtaFULYf307gfu4jvYpV7cgFOjmq5fOgyfb0Gp+SA@mail.gmail.com>
Message-ID: <CAPw-ZTkrqcmtVP8Y2utzAmL0bsMzQtyxnnuE5+PnYNowvYpvZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I will move to the official GIT for 3.12.00 instead rc7. It is the
same as Linux-next GIT.

-Loc

On Wed, Nov 20, 2013 at 12:57 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Wed, Nov 20, 2013 at 7:53 AM, Loc Ho <lho@apm.com> wrote:
>> +
>> +       sprintf(name, "xgene-ahci-phy-%08X", (u32) ctx->csr_phys);
>> +       ctx->phy = devm_phy_create(ctx->dev, (u32) ctx->csr_phys,
>> +                                  &xgene_phy_ops, name);
>
> The devm_phy_create() API has changed, so suggest you make your
> patch against -next tree.
>
> Thanks,
> --
> Ming Lei
>
> --
> Ming Lei
