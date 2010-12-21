From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Dec 2010 13:45:15 +0000
Subject: [PATCH v2 3/3] ARM: twd_smp: add clock api support
In-Reply-To: <1286030086-25556-4-git-send-email-robherring2@gmail.com>
References: <1286030086-25556-1-git-send-email-robherring2@gmail.com>
	<1286030086-25556-4-git-send-email-robherring2@gmail.com>
Message-ID: <20101221134515.GB1556@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 02, 2010 at 09:34:46AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@smooth-stone.com>
> 
> The private timer freq is currently dynamically detected
> using jiffies count to determine the rate. This method adds
> a delay to boot-up, so use the clock api instead to get the
> clock rate.

More or less the same comments go for this as well as the timer-sp code.
