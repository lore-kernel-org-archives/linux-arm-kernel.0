From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Jan 2011 23:53:41 +0000
Subject: [PATCH 1/7] ARM: integrator cp: init clocks early and add
	sp804 clock
In-Reply-To: <1294875123-14086-2-git-send-email-robherring2@gmail.com>
References: <1294875123-14086-1-git-send-email-robherring2@gmail.com>
	<1294875123-14086-2-git-send-email-robherring2@gmail.com>
Message-ID: <20110112235341.GN11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 12, 2011 at 05:31:57PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Move clock initialization to mdesc->init_early and add a clock for
> sp804 timer.

Please wait for my patches to do this.  I've already got them committed
and waiting - init_early was originally intended to solve the sched_clock
initialization issue...

I'll be pushing that stuff out after the merge window has closed.
