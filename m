From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Dec 2013 10:03:04 +0100
Subject: Can someone Ack and queue a patch for RTC subsytem?
In-Reply-To: <20131219184924.13a12247@linux.lan.towertech.it>
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <87sitoka39.fsf@natisbad.org>
 <20131219184924.13a12247@linux.lan.towertech.it>
Message-ID: <20131220090304.GA3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alessandro,

On Thu, Dec 19, 2013 at 06:49:24PM +0100, Alessandro Zummo wrote:
> On Thu, 19 Dec 2013 18:46:18 +0100
> arno at natisbad.org (Arnaud Ebalard) wrote:
> 
> > > I don't mind routing it though mvebu/arm-soc since the only consumers
> > > are currently mvebu boards, but I'd like to hear from Andrew that this
> > > is ok.  
> > 
> > I will do what you think is the best.
> 
>  If the only consumers are mvebu boards, I believe it is correct to
>  route though that tree. imho.

We're pretty much in the same situation for the Allwinner RTC driver

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-November/211849.html

I'm fine with merging it through my tree, however, we still need some
reviews and an Acked-by from you.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131220/1d53aebe/attachment.sig>
