From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Oct 2013 17:39:46 +0000
Subject: [PATCH v5 1/7] arm64: introduce basic aarch64 instruction
 decoding helpers
In-Reply-To: <1382109602-27432-2-git-send-email-liuj97@gmail.com>
References: <1382109602-27432-1-git-send-email-liuj97@gmail.com>
 <1382109602-27432-2-git-send-email-liuj97@gmail.com>
Message-ID: <20131031173946.GL26009@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 04:19:55PM +0100, Jiang Liu wrote:
> +/*
> + * ARMv8-A Section B2.6.5:

Minor comment - please specify the document revision and the title of
the section as they keep changing in subsequent ARMv8 ARM updates and
this comment would no longer match.

-- 
Catalin
