From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jan 2015 15:48:42 +0000
Subject: [PATCHv8 0/2] Better page protections for arm64
In-Reply-To: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
References: <1421890566-29883-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20150122154841.GB28096@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 22, 2015 at 01:36:04AM +0000, Laura Abbott wrote:
> This should be the final version of the series to add stricter page
> protections for arm64. The goal is to have text be RO/X and everything
> else be RW/NX.

Applied. Thanks.

-- 
Catalin
