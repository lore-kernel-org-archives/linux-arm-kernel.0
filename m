From: james.hogan@imgtec.com (James Hogan)
Date: Fri, 10 May 2013 11:41:10 +0100
Subject: [PATCH v2 2/3] clk: add support for clock reparent on set_rate
In-Reply-To: <518C0097.50300@codeaurora.org>
References: <1366388904-13903-1-git-send-email-james.hogan@imgtec.com>
 <1366388904-13903-3-git-send-email-james.hogan@imgtec.com>
 <518C0097.50300@codeaurora.org>
Message-ID: <518CCEC6.5050507@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 21:01, Stephen Boyd wrote:
> I believe we'll need to update the check in __clk_init() to allow you to
> have either a .round_rate or a .determine_rate op if you have a
> .recalc_rate op. Right now it fails to register the clock and then
> oopses later on while setting up clock debugfs.
> 
> Here's a (probably whitespace damaged) patch for the first one.

Thanks, I'll incorporate that.

Cheers
James
