From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 12 Feb 2010 10:01:32 +0100
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100210202552.GA30854@n2100.arm.linux.org.uk>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
	<20100209221449.GA23083@n2100.arm.linux.org.uk>
	<20100210011637.GA8683@shareable.org>
	<20100210134515.GA2844@bnru01.bnr.st.com>
	<20100210202552.GA30854@n2100.arm.linux.org.uk>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E81A321@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell] 

> On Wed, Feb 10, 2010 at 07:15:21PM +0530, Rabin VINCENT wrote:
> > I've implemented this in the updated patch below.
> 
> I think this is ok.  Has it been tested?

I have also regression tested on the U300 (which has a pure,
unmodified PL011 from ARM) and no obvious problems.
Busybox stty seem to say that -crtscts is on by default
so I believe it's in full use now?

I can do further stress tests, just tell me how...

Linus
