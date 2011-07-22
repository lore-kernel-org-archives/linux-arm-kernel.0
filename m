From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 22 Jul 2011 22:28:49 +0200
Subject: [patch 1/3] imx51: add pata device
In-Reply-To: <20110722190957.GF16561@pengutronix.de> ("Uwe =?utf-8?Q?Klein?=
	=?utf-8?Q?e-K=C3=B6nig=22's?=
	message of "Fri, 22 Jul 2011 21:09:57 +0200")
References: <20110722103710.226100346@rtp-net.org>
	<20110722103832.403681566@rtp-net.org>
	<CAOMZO5Cx2Bkz2HGVV5JT2ietT1c4bvt9583FT8iorwsrAN_ZFA@mail.gmail.com>
	<20110722190957.GF16561@pengutronix.de>
Message-ID: <878vrqnjpa.fsf@lebrac.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> On Fri, Jul 22, 2011 at 12:14:15PM -0300, Fabio Estevam wrote:
>> On Fri, Jul 22, 2011 at 7:37 AM, Arnaud Patard
>> <arnaud.patard@rtp-net.org> wrote:
>> ...
>> > +#define imx_mxc_pata_data_entry_single(soc) ? ? ? ? ? ? ? ? ? ? ? ? ? ?\
>> > + ? ? ? { ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> > + ? ? ? ? ? ? ? .iobase = soc ## _ATA_BASE_ADDR, ? ? ? ? ? ? ? ? ? ? ? ?\
>> > + ? ? ? ? ? ? ? .irq = soc ## _MXC_INT_ATA, ? ? ? ? ? ? ? ? ? ? ? ? ? ? \
>> 
>> Why not imx_pata_data_entry_single instead?
>> 
>>  "imx_mxc" looks redundant.
> imx is the platform prefix, mxc_pata the device's name. So IMHO the name
> is right and consistent with the other device registration stuff.
