From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Apr 2014 12:30:03 +0100
Subject: [PATCH_v8 2/2] arm64: audit: Add audit hook in
 syscall_trace_enter/exit()
In-Reply-To: <1394862548-29060-3-git-send-email-takahiro.akashi@linaro.org>
References: <1394705767-12423-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862548-29060-1-git-send-email-takahiro.akashi@linaro.org>
 <1394862548-29060-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140416113002.GG29754@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 05:49:08AM +0000, AKASHI Takahiro wrote:
> This patch adds auditing functions on entry to or exit from
> every system call invocation.
> 
> Acked-by: Richard Guy Briggs <rgb@redhat.com>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

I think I already acked this patch.

Will
