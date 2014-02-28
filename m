From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Feb 2014 15:57:20 +0000
Subject: [PATCH v3 1/2] arm64: make a single hook to syscall_trace() for
 all syscall features
In-Reply-To: <1393564465-3862-2-git-send-email-takahiro.akashi@linaro.org>
References: <1393319683-2707-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
 <1393564465-3862-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140228155720.GD29546@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 28, 2014 at 05:14:24AM +0000, AKASHI Takahiro wrote:
> Currently syscall_trace() is called only for ptrace.
> With additional TIF_xx flags defined, it is now called in all the cases
> of audit, ftrace and seccomp in addition to ptrace.
> 
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
