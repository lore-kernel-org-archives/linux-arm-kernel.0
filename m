From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:13:32 +0000
Subject: [PATCH 2/8] arm64: add FIXMAP_PAGE_NOCACHE definition
In-Reply-To: <1395436128-11244-3-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-3-git-send-email-robherring2@gmail.com>
Message-ID: <20140324111332.GC3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 09:08:42PM +0000, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Similar to ioremap and ioremap_nocache, we want the same definition for
> both using PROT_DEVICE_nGnRE.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
