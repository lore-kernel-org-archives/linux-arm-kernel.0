From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 05 Nov 2014 09:11:35 +0100
Subject: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
In-Reply-To: <20141105011506.GG24112@csclub.uwaterloo.ca>
References: <1412014009-13315-1-git-send-email-bigeasy@linutronix.de>
 <1412014009-13315-12-git-send-email-bigeasy@linutronix.de>
 <20141104170233.GB24112@csclub.uwaterloo.ca> <5459079D.7080703@linutronix.de>
 <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
 <20141105011506.GG24112@csclub.uwaterloo.ca>
Message-ID: <5459DBB7.1090702@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2014 02:15 AM, Lennart Sorensen wrote:
> Well 4 hours running with multiple reboots (our testsuite reboots every
> 30 minutes to test the watchdog).  So far it has only lost 70 bytes out
> of 40MB of data sent between uart7 and uart8 (and we are pretty sure
> the serial test has a small bug that causes a few bytes to be lost right
> after a reboot sometimes).
> 
> The reason I am even trying the new driver today is that we were seeing
> soft lockups on the CPU whenever the serial ports were being tested,
> usually in less than 5 minutes, so 4 hours without a lockup is a good
> sign.  No idea what might be wrong with the old omap serial driver, but
> it seems something is (unless of course we managed to break it somehow
> when we tried to solve its habit of dropping characters).

Okay. No DMA but the basic part seems to work for you. Thanks for
testing.

Sebastian
