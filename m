From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Sep 2014 15:01:30 +0100
Subject: [PATCH v10] arm64: Add architectural support for PCIe
In-Reply-To: <1410184549-17690-2-git-send-email-Liviu.Dudau@arm.com>
References: <1410184549-17690-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184549-17690-2-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140908140129.GE22717@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 02:55:49PM +0100, Liviu Dudau wrote:
> Use the generic PCI domain and OF functions
> to provide support for PCI Express on arm64.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> [Generic PCI domain support]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Minor detail: when have I signed this patch off? I'm not the author
(maybe bits of it but I think most of it is yours). However, you can
add:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
