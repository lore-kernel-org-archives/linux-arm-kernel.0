From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Sat, 26 Feb 2011 19:33:23 +0100
Subject: [PATCH RESEND 2.6.39 0/3] ARM: simpad: Add support for GPIO
	attached hardware
In-Reply-To: <1298023368-27090-1-git-send-email-jochen@scram.de>
References: <1298023368-27090-1-git-send-email-jochen@scram.de>
Message-ID: <20110226183322.GB1951@Boggieman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 18, 2011 at 11:02:45AM +0100, Jochen Friedrich wrote:
> This series enables GPIO API on UCB1x00 and implements the GPIO
> API on the CS3 latch. The third patch finally registers platform
> devices for the GPIO attached LED, buttons and I2C bus.
> 

You gotten any feedback on those patches?

> ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
> ARM: simpad: Cleanup CS3 accessors and add GPIO API
> ARM: simpad: add GPIO based device definitions
