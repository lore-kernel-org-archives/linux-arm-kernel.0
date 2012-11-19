From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 19 Nov 2012 19:50:14 +0100
Subject: [PATCH 4/7] arm: mvebu: move DT cpu clock nodes to the Armada
 XP specific .dtsi
In-Reply-To: <20121119183803.GT14643@lunn.ch>
References: <1353343963-23034-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1353343963-23034-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20121119183803.GT14643@lunn.ch>
Message-ID: <20121119195014.07fed9f5@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Andrew Lunn,

On Mon, 19 Nov 2012 19:38:03 +0100, Andrew Lunn wrote:

> This is only part of the story:
> 
> void __init of_cpu_clk_setup(struct device_node *node)

[...]

>         for (cpu = 0; cpu < MAX_CPU; cpu++) {

[...]

> You are still registering 4 clocks as far as i can see.

Aah, correct. I'll fix this and resend!

Thanks for the review,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
