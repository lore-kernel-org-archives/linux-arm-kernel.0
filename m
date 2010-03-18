From: armando.visconti@st.com (Armando VISCONTI)
Date: Thu, 18 Mar 2010 14:45:39 +0100
Subject: devicetree in arm
In-Reply-To: <20100318132358.GE19544@n2100.arm.linux.org.uk>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>	<fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
	<20100318132358.GE19544@n2100.arm.linux.org.uk>
Message-ID: <4BA22E83.3080000@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,


>> ARM device tree support is very much in flux, and that particular
>> branch gets rebased a lot as device tree code from Sparc, Microblaze
>> and Powerpc is merged into drivers/of.  I may have ended up pushing
>> out to test-devicetree without the ARM patches applied.  I'll look at
>> it today, make sure the ARM stuff is all there, and then push it out
>> again.
>>
>> Note however that this is only very basic support.  It doesn't yet
>> have the code needed to register devices and drivers from device tree
>> data.  That will be coming real-soon-now.
>>     
>
> Is someone going to do a device tree example port to a 'real' platform
> rather than simple the ARM evaluation boards?
>   
As part of the discussion we had recently with you guys I can tell you
that we are of course interested into this devicetree info passed
as booting option.

We are currently in the process of submitting on this mailing list
the patch V2 for SPEAr family architectures for reviewing.

> As I've said previously, I'm not going to accept device tree stuff until
> I see a working implementation on a set of real platforms.
>   
Just after submitting patch V2 we might take a look to this patch and 
try it out
on our SPEAr platforms. It might take long as it is not exactly
our first priority.

We will keep you informed on this.

Regards,
Arm
