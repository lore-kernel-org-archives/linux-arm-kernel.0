From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Mar 2014 12:19:47 +0000
Subject: [PATCH v6 2/7] arm64: Add 'notrace' attribute to unwind_frame()
 for ftrace
In-Reply-To: <1394705630-12384-3-git-send-email-takahiro.akashi@linaro.org>
References: <1393564724-3966-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-1-git-send-email-takahiro.akashi@linaro.org>
 <1394705630-12384-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20140313121947.GE12331@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 13, 2014 at 10:13:45AM +0000, AKASHI Takahiro wrote:
> walk_stackframe() calls unwind_frame(), and if walk_stackframe() is
> "notrace", unwind_frame() should be also "notrace".
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Acked-by: Will Deacon <will.deacon@arm.com>

Will
