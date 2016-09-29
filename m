From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Thu, 29 Sep 2016 16:46:07 +0200
Subject: [PULL 00/50] KVM/ARM Changes for v4.9
In-Reply-To: <20160927180558.14699-1-christoffer.dall@linaro.org>
References: <20160927180558.14699-1-christoffer.dall@linaro.org>
Message-ID: <20160929144606.GA24662@potion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-27 20:05+0200, Christoffer Dall:
> Hi Paolo and Radim,
> 
> Here are the KVM/ARM Changes for v4.9. They include:
> 
>  - Various cleanups and removal of redundant code
>  - Two important fixes for not using an in-kernel irqchip
>  - A bit of optimizations
>  - Handle SError exceptions and present them to guests if appropriate
>  - Proxying of GICV access at EL2 if guest mappings are unsafe
>  - GICv3 on AArch32 on ARMv8
>  - Preparations for GICv3 save/restore, including ABI docs

Pulled to kvm/next, thanks.
