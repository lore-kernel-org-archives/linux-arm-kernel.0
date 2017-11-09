From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Thu, 9 Nov 2017 19:04:37 +0100
Subject: [PULL 00/26] KVM/ARM Changes for v4.15
In-Reply-To: <20171107104800.30021-1-christoffer.dall@linaro.org>
References: <20171107104800.30021-1-christoffer.dall@linaro.org>
Message-ID: <20171109180436.GB15561@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-11-07 11:47+0100, Christoffer Dall:
> Hi Paolo and Radim,
> 
> Here is the first round of KVM/ARM Changes for v4.15.  I will follow up
> with a second pull request based on tip:irq/core containing the KVM/ARM
> side of the GICv4 support.
> 
> Changes in this pull requestinclude:
>  - Optimized arch timer handling for KVM/ARM
>  - Improvements to the VGIC ITS code and introduction of an ITS reset
>    ioctl
>  - Unification of the 32-bit fault injection logic
>  - More exact external abort matching logic

Pulled, thanks.
