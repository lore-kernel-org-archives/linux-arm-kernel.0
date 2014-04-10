From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Thu, 10 Apr 2014 13:10:23 +0000 (UTC)
Subject: [PATCH v2] arm64: enable EDAC on arm64
References: <1385154308-31335-1-git-send-email-robherring2@gmail.com>
Message-ID: <loom.20140410T150903-818@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2 <at> gmail.com> writes:

> 
> From: Rob Herring <rob.herring <at> calxeda.com>
> 
> Implement atomic_scrub and enable EDAC for arm64.
> 
> Signed-off-by: Rob Herring <rob.herring <at> calxeda.com>
> Cc: Catalin Marinas <catalin.marinas <at> arm.com>
> Cc: Will Deacon <will.deacon <at> arm.com>
> ---
> v2:
> - Add loop for exclusive store success
> - Fix size to be 32-bits at a time. The framework gives no alignment
>   guarantees.
> 

Hi Rob,

I am working on memory error for ARM64 and wondering what is your plans 
regarding this patch. It looks essential for my further work.

Regards,
Tomasz
