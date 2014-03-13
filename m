From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 18:43:11 +0000
Subject: [PATCH v7 2/2] arm64: audit: Add audit hook in
 syscall_trace_enter/exit()
In-Reply-To: <1394705767-12423-3-git-send-email-takahiro.akashi@linaro.org>
References: <1393564635-3921-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705767-12423-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705767-12423-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140313184311.GM25472@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:16:07AM +0000, AKASHI Takahiro wrote:
> This patch adds auditing functions on entry to or exit from
> every system call invocation.
> 
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
