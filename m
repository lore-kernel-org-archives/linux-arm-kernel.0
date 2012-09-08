From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 8 Sep 2012 22:56:10 +0100
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <201209061546.45242.arnd@arndb.de>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209060904.14903.arnd@arndb.de> <20120906094703.GA7308@glitch>
 <201209061546.45242.arnd@arndb.de>
Message-ID: <20120908215609.GH13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 06, 2012 at 03:46:44PM +0000, Arnd Bergmann wrote:
> We just had a discussion about
> stale platforms at the ARM mini summit in San Diego. IMHO if a port
> gets started and then nobody works on filling the gaps for two
> years, we should remove it again. 

One of the issues there is that you don't know if the reason it's not
receiving patches or comments is because it works and people are using
it, and they don't have anything to report against it.

That's certainly true of a number of platforms we currently have.

And then there's the ones I run services on which I don't tend to reboot
very often.  I'm currently looking at one which is coming up to 1000 days
uptime which has had zero problems on a 2.6.32.8 kernel - in fact it's
the one which provides www.arm.linux.org.uk and I'm typing this email
message on...

 22:54:19 up 938 days,  9:27, 11 users,  load average: 0.21, 0.08, 0.01

so in that case I'm not going to know if anything is broken on an IOP32x
kernel until that gets rebooted (which it will do soon because I want to
change its disks - but hopefully not before 62 days time.)
