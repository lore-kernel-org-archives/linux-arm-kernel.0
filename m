From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Mar 2017 18:23:09 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170311121453.18534-1-zajec5@gmail.com>
References: <20170311121453.18534-1-zajec5@gmail.com>
Message-ID: <20170311172309.GC15842@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 01:14:53PM +0100, Rafa?? Mi??ecki wrote:
> From: Rafa?? Mi??ecki <rafal@milecki.pl>
> 
> This is BCM47081A0 based home router with BCM43217 and BCM4352 wireless
> chipsets.
 
Hi Rafal

Have you made any progress with the Ethernet switch? Does anybody know
if it is compatible with the SF2/B53 DSA driver?

I have a DIR 860l v1 router, using the same chipset. I'm interested in
the switch, given my DSA maintainer role.

Thanks
	Andrew
