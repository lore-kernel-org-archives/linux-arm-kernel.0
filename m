From: andy@warmcat.com (Andy Green)
Date: Mon, 28 Dec 2009 19:07:15 +0000
Subject: Ethernet in a cold climate / SMDK6410
In-Reply-To: <20091228190009.GB14799@sirena.org.uk>
References: <4B38FB80.9050609@warmcat.com>
	<20091228190009.GB14799@sirena.org.uk>
Message-ID: <4B3901E3.20004@warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/28/09 19:00, Somebody in the thread at some point said:

Hi Mark -

>> What is the deal with that in terms of SDMK settings and assumptions
>> about bootloader prepping nCS signals?  SMDK docs I have let me
>> twiddle switches and get "ethernet" connected to various selects.
>> What does 0x18000000 represent and how should the board be set so
>> CS8900A doesn't crash the party?
>
> I've never used the board with the CS8900A enabled, the bootloaders I've
> seen appear to support the SMSC chip only.
>
> The memory address was lifted from the Samsung BSP code IIRC.

Thanks for the quick reply.

It's fine if I get the SMSC chip happy, I just mention the CS8900A 
because it is there are the docs only talk about "ethernet" so I expect 
conflict.

So what was your setup when Ethernet worked OK...

  - the Samsung U-Boot fork that came with the SMDK?

  - magic address 0x18000000 OK

  - 60+ minidip config was what?

I'm guessing 0x18000000 is on a particular nCS signal that needs 
configuring (should that really not be the business of the machine 
definition file?) and the mini DIPs setting to match.

-Andy
