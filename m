From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 18 Mar 2010 07:54:05 -0600
Subject: devicetree in arm
In-Reply-To: <20100318132358.GE19544@n2100.arm.linux.org.uk>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
	<fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
	<20100318132358.GE19544@n2100.arm.linux.org.uk>
Message-ID: <fa686aa41003180654y56b8ea4elee3c13590b896c5a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 7:23 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Mar 18, 2010 at 07:14:05AM -0600, Grant Likely wrote:
>> ARM device tree support is very much in flux, and that particular
>> branch gets rebased a lot as device tree code from Sparc, Microblaze
>> and Powerpc is merged into drivers/of. ?I may have ended up pushing
>> out to test-devicetree without the ARM patches applied. ?I'll look at
>> it today, make sure the ARM stuff is all there, and then push it out
>> again.
>>
>> Note however that this is only very basic support. ?It doesn't yet
>> have the code needed to register devices and drivers from device tree
>> data. ?That will be coming real-soon-now.
>
> Is someone going to do a device tree example port to a 'real' platform
> rather than simple the ARM evaluation boards?

I'm working on OMAP and others, and Jeremy is working on i.MX51
targeting real product.  Visible progress has been slow since there is
a lot more back end infrastructure work than I was expecting to get
the ppc, sparc and microblaze code merged into a common code base and
to move away from the whole of_platform bus stuff (so that regular
platform drivers work).  The alternative would be to add yet another
duplicate copy of device tree code to ARM which I will not do, and I
know you wouldn't accept anyway.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
