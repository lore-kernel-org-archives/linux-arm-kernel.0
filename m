From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 26 Aug 2014 19:24:50 +0100
Subject: [PATCH] efi/arm64: store Runtime Services revision
In-Reply-To: <20140826090533.GA3193@arm.com>
References: <1408028122-1784-1-git-send-email-semen.protsenko@linaro.org>
 <20140826090533.GA3193@arm.com>
Message-ID: <20140826182450.GA28116@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Aug, at 10:05:33AM, Will Deacon wrote:
> 
> I doubt it makes any difference, but can we assign this before we call
> efi_native_runtime_setup please?

This would have to be a follow up patch, v2 of this patch is already in
Linus' tree as commit 6a7519e81321.

-- 
Matt Fleming, Intel Open Source Technology Center
