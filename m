From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 17:26:43 +0100
Subject: [PATCH v7 11/16] arm64: Promote KERNEL_START/KERNEL_END
 definitions to a header file
In-Reply-To: <1459529620-22150-12-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-12-git-send-email-james.morse@arm.com>
Message-ID: <20160420162643.GE11377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:35PM +0100, James Morse wrote:
> KERNEL_START and KERNEL_END are useful outside head.S, move them to a
> header file.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
