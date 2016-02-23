From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Feb 2016 11:30:59 +0000
Subject: [PATCH] clk: gpio: Really allow an optional clock= DT property
In-Reply-To: <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
References: <20160219030731.GS4847@codeaurora.org>
 <1455851525-18972-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160223113059.GH19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 07:12:05PM -0800, Stephen Boyd wrote:
> We mis-merged the original patch from Russell here and so the
> patch went almost all the way, except that we still failed to
> probe when there wasn't a clocks property in the DT node. Allow
> that case by making a negative value from
> of_clk_get_parent_count() into "no parents", like the original
> patch did.

So you apply it anyway, and ignore all further discussion.  I've
no idea what kind of politics is going on here, but it has to stop.

I'm also still waiting for that apology from Mike - never apply a
modified patch without stating in the commit log that it was modified.
It's basically fraud.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
