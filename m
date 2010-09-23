From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 23 Sep 2010 12:21:14 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100923093104.GA22397@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Sep 2010 10:31:04 +0100")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
Message-ID: <87fwx0ahgl.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:

Hi,

 Russell> udelay(5) should always give something approximating a 5us
 Russell> delay, as we calibrate this delay loop against the system
 Russell> timer.  What I could believe is probably going on here is that
 Russell> writing to the hardware is adding additional delays - but
 Russell> that's nothing to do with the CPU speed itself.

Well, the gpio handling (sw) overhead is to a certain degree related to
the CPU speed.

-- 
Bye, Peter Korsgaard
