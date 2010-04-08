From: bryan.wu@canonical.com (Bryan Wu)
Date: Thu, 08 Apr 2010 14:41:30 +0800
Subject: devicetree in arm
In-Reply-To: <k2tfa686aa41004072331p7541292ajc35521cf24fd24c6@mail.gmail.com>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
	<fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
	<20100318132358.GE19544@n2100.arm.linux.org.uk>	<4BA28BF7.2080403@billgatliff.com>
	<k2tfa686aa41004072331p7541292ajc35521cf24fd24c6@mail.gmail.com>
Message-ID: <4BBD7A9A.9090501@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely wrote:
> On Thu, Mar 18, 2010 at 2:24 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
>   
>> Russell King - ARM Linux wrote:
>>     
>>> On Thu, Mar 18, 2010 at 07:14:05AM -0600, Grant Likely wrote:
>>>
>>>       
>>>> ARM device tree support is very much in flux, and that particular
>>>> branch gets rebased a lot as device tree code from Sparc, Microblaze
>>>> and Powerpc is merged into drivers/of.  I may have ended up pushing
>>>> out to test-devicetree without the ARM patches applied.  I'll look at
>>>> it today, make sure the ARM stuff is all there, and then push it out
>>>> again.
>>>>
>>>> Note however that this is only very basic support.  It doesn't yet
>>>> have the code needed to register devices and drivers from device tree
>>>> data.  That will be coming real-soon-now.
>>>>
>>>>         
>>> Is someone going to do a device tree example port to a 'real' platform
>>> rather than simple the ARM evaluation boards?
>>>
>>> As I've said previously, I'm not going to accept device tree stuff until
>>> I see a working implementation on a set of real platforms.
>>>
>>>       
>> I can give it a spin on a couple of the boards I have here.  I'm already
>> using device trees on my PPC platforms.
>>     
>
> Hi Bill.  I've just pushed out my tree with a bit of the device tree
> probing working on the versatile platform.  It works with the QEMU
> branch that Jeremy Kerr is maintaining.  Here are the git trees, and
> the web page that describes how to build it:
>
> git://git.secretlab.ca/git/linux-2.6 test-devicetree
> git://git://kernel.ubuntu.com/jk/dt/qemu.git
> https://wiki.ubuntu.com/KernelTeam/ARMDeviceTrees
>
> I've got stuff working on real hardware too, but it's not fully baked
> yet.  Right now qemu is the least trouble.
>
> g.
>
>   

Grant and Jeremy,

I'm very happy to try that on my real Freescale i.MX51 board. Any hints 
about that?

Cheers,
-Bryan
