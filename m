From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 17 Jul 2015 12:06:56 +0100
Subject: [PATCH 2/5] arm64: kernel: Add cpufeature 'enable' callback.
In-Reply-To: <1437062519-18883-3-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
 <1437062519-18883-3-git-send-email-james.morse@arm.com>
Message-ID: <20150717110655.GD13712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 05:01:56PM +0100, James Morse wrote:
> This patch adds an 'enable()' callback to cpu capability/feature
> detection, allowing features that require some setup or configuration
> to get this opportunity once the feature has been detected.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
