From: will.deacon@arm.com (Will Deacon)
Date: Mon, 21 Dec 2015 12:05:57 +0000
Subject: [PATCH v7 0/6] arm64: ftrace: fix incorrect output from stack
 tracer
In-Reply-To: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
References: <1450168424-10010-1-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20151221120557.GJ23092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 05:33:38PM +0900, AKASHI Takahiro wrote:
> This is the seventh patch series to fix ftrace-based stack tracer on
> arm64. The original issue was reported by Jungseok[1], and then I found
> more issues[2].
> 
> We don't have to care about the original issue any more because the root
> cause (patch "ARM64: unwind: Fix PC calculation") has been reverted in
> v4.3.

I've queued the first three patches, but I'm going to hold off on the
prologue analyser until you've got some feedback from the GCC guys.

Will
