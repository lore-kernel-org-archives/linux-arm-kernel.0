From: will.deacon@arm.com (Will Deacon)
Date: Tue, 4 Feb 2014 17:30:02 +0000
Subject: [PATCH v3 1/3] arm64: Add regs_return_value() in syscall.h
In-Reply-To: <1391410590-4884-2-git-send-email-takahiro.akashi@linaro.org>
References: <1389946399-4525-1-git-send-email-takahiro.akashi@linaro.org>
 <1391410590-4884-1-git-send-email-takahiro.akashi@linaro.org>
 <1391410590-4884-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140204173002.GE664@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 03, 2014 at 06:56:28AM +0000, AKASHI Takahiro wrote:
> This macro, regs_return_value, is used mainly for audit to record system
> call's results, but may also be used in test_kprobes.c.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
