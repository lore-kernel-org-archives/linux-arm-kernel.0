From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2016 13:40:33 +0000
Subject: [PATCH] arm64/mm: remove unnecessary boundary check
In-Reply-To: <1456371874-19826-1-git-send-email-miles.chen@mediatek.com>
References: <1456371874-19826-1-git-send-email-miles.chen@mediatek.com>
Message-ID: <20160226134033.GK4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 25, 2016 at 11:44:34AM +0800, miles.chen at mediatek.com wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> Remove the unnecessary boundary check since there is a huge
> gap between user and kernel address that they would never overlap.
> (arm64 does not have enough levels of page tables to cover 64-bit
> virtual address)
> 
> See Documentation/arm64/memory.txt
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>

Applied. Thanks.

-- 
Catalin
