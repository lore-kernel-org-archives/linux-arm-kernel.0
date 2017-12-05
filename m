From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Tue, 5 Dec 2017 18:59:39 +0100
Subject: [PULL 00/19] KVM/ARM Fixes for v4.15
In-Reply-To: <20171204135637.21620-1-cdall@kernel.org>
References: <20171204135637.21620-1-cdall@kernel.org>
Message-ID: <20171205175938.GB20099@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-12-04 14:56+0100, Christoffer Dall:
> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Hi Paolo and Radim,
> 
> Here's the first round of fixes for KVM/ARM for v4.15.  This is a fairly large
> set of fixes, partially because we spotted a handful of issues from running the
> SMATCH static analysis on the code (thanks to AKASHI Takahiro).
> 
> In more details, this pull request fixes:
>  - A number of issues in the vgic discovered using SMATCH
>  - A bit one-off calculation in out stage base address mask (32-bit and
>    64-bit)
>  - Fixes to single-step debugging instructions that trap for other
>    reasons such as MMMIO aborts
>  - Printing unavailable hyp mode as error
>  - Potential spinlock deadlock in the vgic
>  - Avoid calling vgic vcpu free more than once
>  - Broken bit calculation for big endian systems

Pulled, thanks.
