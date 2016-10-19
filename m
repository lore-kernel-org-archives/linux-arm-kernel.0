From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 18 Oct 2016 20:07:07 -0400
Subject: [PATCH/RESEND] recordmcount: arm: Implement make_nop
In-Reply-To: <20161018234200.5804-1-sboyd@codeaurora.org>
References: <20161018234200.5804-1-sboyd@codeaurora.org>
Message-ID: <20161018200707.36e549ee@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Oct 2016 16:42:00 -0700
Stephen Boyd <sboyd@codeaurora.org> wrote:

> In similar spirit to x86 and arm64 support, add a make_nop_arm()
> to replace calls to mcount with a nop in sections that aren't
> traced.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Acked-by: Rabin Vincent <rabin@rab.in>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

I can take this if I can get an ack from the ARM maintainers.

-- Steve
