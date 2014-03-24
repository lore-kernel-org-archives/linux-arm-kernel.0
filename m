From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Mar 2014 11:38:54 +0000
Subject: [PATCH 3/8] arm64: enable FIX_EARLYCON_MEM kconfig
In-Reply-To: <1395436128-11244-4-git-send-email-robherring2@gmail.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-4-git-send-email-robherring2@gmail.com>
Message-ID: <20140324113854.GG3850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 09:08:43PM +0000, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> In order to support earlycon on arm64, we need to enable earlycon fixmap
> support.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
