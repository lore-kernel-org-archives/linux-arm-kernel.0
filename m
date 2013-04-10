From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Apr 2013 12:41:27 +0100
Subject: [PATCH v2] arm64: Fix task tracing
In-Reply-To: <1365510814-21343-1-git-send-email-cov@codeaurora.org>
References: <20130408153132.GQ17476@mudshark.cambridge.arm.com>
 <1365510814-21343-1-git-send-email-cov@codeaurora.org>
Message-ID: <20130410114126.GB26992@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 01:33:34PM +0100, Christopher Covington wrote:
> For accurate accounting pass contextidr_thread_switch the prev
> task pointer, since cpu_switch_to has at that point changed the
> the stack pointer.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>

Thanks Christopher -- I assume that using prev did resolve your issues?

Will
