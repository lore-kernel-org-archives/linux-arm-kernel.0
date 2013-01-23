From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 23 Jan 2013 16:51:56 +0800
Subject: [PATCH] ARM: PXA3xx: program the CSMSADRCFG register
In-Reply-To: <CAMPhdO8LfzvjoE1Re9G44pAZh+-9U7aj5gUWj2xeUyV1ihyRSg@mail.gmail.com>
References: <1358077787-31518-1-git-send-email-grinberg@compulab.co.il>
 <CAMPhdO8LfzvjoE1Re9G44pAZh+-9U7aj5gUWj2xeUyV1ihyRSg@mail.gmail.com>
Message-ID: <CAN1soZyaUXSNaXNT-bLirh7FDjm9QnYZq_QUUAJt8Tjo=Febeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 15, 2013 at 11:01 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
>
> On Sun, Jan 13, 2013 at 7:49 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> > The Chip Select Configuration Register must be programmed to 0x2 in
> > order to achieve the correct behavior of the Static Memory Controller.
> >
> > Without this patch devices wired to DFI and accessed through SMC cannot
> > be accessed after resume from S2.
> >
> > Do not rely on the boot loader to program the CSMSADRCFG register by
> > programming it in the kernel smemc module.
> >
>
> Looks good to me. Acked-by: Eric Miao <eric.y.miao@gmail.com>
>

Appled.

Thanks.
Haojian
