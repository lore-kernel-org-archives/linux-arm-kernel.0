From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Mon, 07 Mar 2011 17:02:28 +0100
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
	(Nguyen Dinh-R's message of "Mon, 7 Mar 2011 15:37:38 +0000")
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	<87oc5puwg3.fsf@lebrac.rtp-net.org>
	<56132A77AB93C141BF06E6B96CA6CFEA193F14@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <87fwqyvrzf.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nguyen Dinh-R00091 <R00091@freescale.com> writes:

> Hi Arnaud,

Hi,
>
> Just to verify that you are testing on an MX51-Babbage board? Here's my log:

I never said I was testing on babbage. The reason is because I'm using a
efika smartbook and not a babbage.

>
> root at freescale ~$ uname -a
> Linux freescale 2.6.38-rc1+ #93 Fri Mar 4 17:18:15 CST 2011 armv7l GNU/Linux

2.6.38-rc1+ ? which tree are you using ? The for-next branch of Sascha
Hauer's tree is at least 2.6.38-rc5 so you're trying to merge something
without even testing it on the current tree. Can you please test suspend
with current imx for-next tree (with no other patches than theses 2
patches if possible), in order to make sure that it's still working with it ?

Thanks,
Arnaud
