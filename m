From: ulrich.prinz@googlemail.com (Ulrich Prinz)
Date: Sat, 06 Jul 2013 22:28:52 +0200
Subject: [PATCH 9/9] clocksource: dw_apb_timer: special variant for
 rockchip rk3188 timers
In-Reply-To: <alpine.DEB.2.02.1307060153110.32106@ionos.tec.linutronix.de>
References: <201307060051.09716.heiko@sntech.de>
 <201307060056.29370.heiko@sntech.de>
 <alpine.DEB.2.02.1307060153110.32106@ionos.tec.linutronix.de>
Message-ID: <51D87E04.3060704@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, ok...

I got the message. With modifying the existing driver to support more
function pointers in its system struct and assigning them at the
beginning, and using them on runtime, these quirks are obsolete.

Again, this is the first time I provide code to the kernel officially
and I learned from others that I should try it by modifying not too much
code if not needed.

Adding more function pointers to a system relevant structure, doubling
the number of functions and such didn't look non-invasive to me.

But, I totally agree with your argumentation and I even wanted to do it
in the way you explained in your replies. Just the courage was missing I
guess :)

Regards,
	Ulrich
