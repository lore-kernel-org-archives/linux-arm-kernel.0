From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Wed, 20 Oct 2010 11:26:05 +0200
Subject: [patch 3/9] imx51: enhance/fix iomux configuration
In-Reply-To: <4CBEB2F7.5020700@eukrea.com> ("Eric =?utf-8?Q?B=C3=A9nard=22?=
	=?utf-8?Q?'s?= message of "Wed\, 20 Oct 2010 11\:14\:31 +0200")
References: <20101019204253.162641893@rtp-net.org>
	<20101019205254.232673283@rtp-net.org> <4CBEB2F7.5020700@eukrea.com>
Message-ID: <87iq0xcj0y.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eric B?nard <eric@eukrea.com> writes:

> Hi Arnaud,

Hi,
>
> in this patch, you break configuration for all the GPIO_1_x here (the
> correct lat mux for GPIO mode on pins GPIO_1_x is 1 and not 0).

No. For instance, page 3447 of the MCIMX51RM.pdf thing :

000: Select mux mode: ALT0 mux port: GPIO[8] of instance: gpio1.

or page 3441 :

000: Select mux mode: ALT0 mux port: GPIO[3] of instance: gpio1

How is possible that 000b is equal to 1 ?

Arnaud
