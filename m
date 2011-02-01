From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Feb 2011 20:36:25 +0000
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <4D486E08.9000709@codeaurora.org>
References: <201102011711.31258.jeremy.kerr@canonical.com>
	<20110201105449.GY1147@pengutronix.de>
	<20110201131512.GH31216@n2100.arm.linux.org.uk>
	<20110201141837.GA1147@pengutronix.de>
	<20110201143932.GK31216@n2100.arm.linux.org.uk>
	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
	<4D486E08.9000709@codeaurora.org>
Message-ID: <20110201203625.GT31216@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 01, 2011 at 12:33:12PM -0800, Saravana Kannan wrote:
> Looks like this is the best acknowledgment/response I can expect to get  
> from Russell on this point that I raised.

Sorry, I've been up to my eyeballs with other stuff over the last few
weeks.  Yes, I think clk_set_rate() needs to be sleep-able too.
