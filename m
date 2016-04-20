From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 20 Apr 2016 17:25:37 +0100
Subject: [PATCH v7 10/16] arm64: kernel: Include _AC definition in page.h
In-Reply-To: <1459529620-22150-11-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-11-git-send-email-james.morse@arm.com>
Message-ID: <20160420162537.GD11377@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 05:53:34PM +0100, James Morse wrote:
> page.h uses '_AC' in the definition of PAGE_SIZE, but doesn't include
> linux/const.h where this is defined. This produces build warnings when only
> asm/page.h is included by asm code.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
