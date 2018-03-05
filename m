From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Mon, 05 Mar 2018 14:42:37 +0100
Subject: [PATCH] serial: mvebu_uart: fix tx lost characters
In-Reply-To: <20180305111012.0ea44d1d@xps13> (Miquel Raynal's message of "Mon,
 5 Mar 2018 11:10:12 +0100")
References: <3B588D51285A4A4D8D39C94212E0782627008E@SPQCMBX02.exfo.com>
 <20180227141255.177ea751@xps13>
 <3B588D51285A4A4D8D39C94212E07826271B70@SPQCMBX02.exfo.com>
 <20180305104721.311a02c2@xps13> <20180305111012.0ea44d1d@xps13>
Message-ID: <87lgf663le.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gabriel,
 
 On lun., mars 05 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Gabriel,
>
> On Mon, 5 Mar 2018 10:47:21 +0100, Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>
>> Hi Gabriel,
>> 
>> On Tue, 27 Feb 2018 21:56:03 +0000, Gabriel Matni
>> <gabriel.matni@exfo.com> wrote:
>> 
>> > Hi Miqu?l,
>> >   
>> > > -----Original Message-----
>> > > From: Miquel Raynal [mailto:miquel.raynal at bootlin.com]
>> > > Sent: February 27, 2018 8:13 AM
>> > > To: Gabriel Matni <gabriel.matni@exfo.com>
>> > > Cc: linux-arm-kernel at lists.infradead.org; gregkh at linuxfoundation.org;
>> > > Gr?gory Clement <gregory.clement@bootlin.com>; Thomas Petazzoni
>> > > <thomas.petazzoni@bootlin.com>
>> > > Subject: Re: [PATCH] serial: mvebu_uart: fix tx lost characters

Given the review done by Miquel and the information you add, you can
also add my
Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>


>
> BTW, prefix should be "serial: mvebu-uart:".
>
> And maybe you should CC: stable too?

And also adding the following fixes tag:

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for
Armada-3700 serial port")


Thanks,

Gregory

>
> Thanks for fixing it anyway.
> Miqu?l

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
