From: viresh.linux@gmail.com (viresh kumar)
Date: Thu, 25 Feb 2010 18:37:37 +0530
Subject: QUERY: How to call board specific initialization function before
	map_io or timer_init
Message-ID: <22dbbef21002250507s12664df5q36e50a8f9e0bc3b9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I need to call my board specific initialization routine before
timer_init or map_io is called.
I tried to see that in earlier architectures and found most of
architecture call machine
specific init function from map_io or init_irq or init_machine.

Situation: I need to register my clock framework with
arch/arm/common/clkdev framework
before actually initializing timer. So i can't do this in
"init_machine" as timer_init is called
before that.

Can anybody please help.

regards,
viresh kumar
ST Microelectronics
India
