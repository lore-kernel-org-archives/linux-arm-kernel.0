From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 18:28:06 +0000
Subject: [PATCH v4 1/3] arm64: make a single hook to syscall_trace() for
 all syscall features
In-Reply-To: <1394705491-12343-2-git-send-email-takahiro.akashi@linaro.org>
References: <1393564465-3862-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705491-12343-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705491-12343-2-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140313182805.GJ25472@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:11:29AM +0000, AKASHI Takahiro wrote:
> Currently syscall_trace() is called only for ptrace.
> With additional TIF_xx flags defined, it is now called in all the cases
> of audit, ftrace and seccomp in addition to ptrace.
> 
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will
