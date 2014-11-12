From: gmbnomis@gmail.com (Simon Baatz)
Date: Wed, 12 Nov 2014 20:48:05 +0100
Subject: Network timing (?) problems since kernel 3.12
In-Reply-To: <545F9CC5.6070709@drkrebs.de>
References: <545F852D.5040209@drkrebs.de> <20141109155502.GA10013@lunn.ch>
 <545F9CC5.6070709@drkrebs.de>
Message-ID: <20141112194805.GA27092@schnuecks.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Sun, Nov 09, 2014 at 05:56:37PM +0100, Markus Krebs wrote:
> Am 09.11.2014 um 16:55 schrieb Andrew Lunn:
> 
> >>I'm using a Sheevaplug (Marvell Kirkwood) with an USB-Stick for
> >>storage as a server. Since kernel 3.12 I'm experiencing various
> >>erratic problems when transferring files, especially large or many
> >>files at the same time, over the network (ssh complaining about
> >>"Corrupted MAC on input" or Windows [over Samba] about corrupt
> >>files).
> >>Turning "offload check summing" off with ethtool didn't really help.
> >
> >Try turning off gso.
> 
> Thanks, Andrew; I've tried now but that didn't do the trick either.

I am not able to provoke this behaviour on my Sheevaplug using a
stock 3.12.32 kernel (but that does not mean much.  Just did some
quick tests by copying large files from an USB stick using ssh or
netcat).

Could you elaborate on the actual kernel and config you are using? 
Is there a simple testcase that reliably reproduces the behaviour on
your box?
 
- Simon
