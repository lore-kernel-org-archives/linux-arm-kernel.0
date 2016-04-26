From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Apr 2016 12:29:19 +0100
Subject: [PATCH v2 0/6] arm64/ARM pt dumper changes
In-Reply-To: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1461343688-8552-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160426112918.GK27312@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2016 at 06:48:02PM +0200, Ard Biesheuvel wrote:
> This series updates the kernel page table dumper to:
> - not initialize the vmemmap region markers dynamically
> - show region boundaries for the kasan shadow region
> - include the UEFI runtime services mappings

I've merged the first two patches of this series. I can take patch 4 too
if you can rebase onto for-next/core.

Cheers,

Will
