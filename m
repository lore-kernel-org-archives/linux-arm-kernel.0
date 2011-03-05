From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Sat, 05 Mar 2011 21:46:52 +0100
Subject: [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
In-Reply-To: <56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
	(Nguyen Dinh-R's message of "Fri, 4 Mar 2011 23:33:11 +0000")
References: <1299281399-32304-1-git-send-email-Dinh.Nguyen@freescale.com>
	<56132A77AB93C141BF06E6B96CA6CFEA19124C@039-SN1MPN1-004.039d.mgd.msft.net>
Message-ID: <87oc5puwg3.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nguyen Dinh-R00091 <R00091@freescale.com> writes:

> Hi Arnaud,

Hi,

>
> I just sent out a 2nd set of the MX51 LPM patch. I have tested successfully on my mx51 babbage without any code modifications.
>
> If you would kindly verify on your side, that would great.
>
> You need both patches:
>
> [PATCHv2 1/2] ARM: mx51: Implement code to allow mx51 to enter WFI
> [PATCHv2 2/2] ARM: mx51: Add support for low power suspend on MX51

No success. I even tried disabling nearly all drivers and nothing. The
last line I have in the serial console is :

PM: late suspend of devices complete after 0.354 msecs

So, I still don't know if the system is crashing while suspending or if
the system is suspended but doesn't wake up.

Arnaud
