From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 12:19:03 +0000
Subject: [PATCH v6 1/7] arm64: add __ASSEMBLY__ in asm/insn.h
In-Reply-To: <1394705630-12384-2-git-send-email-takahiro.akashi@linaro.org>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140313121903.GD12331@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:13:44AM +0000, AKASHI Takahiro wrote:
> Since insn.h is indirectly included in asm/entry-ftrace.S,
> we need to exclude some declarations by __ASSEMBLY__.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
