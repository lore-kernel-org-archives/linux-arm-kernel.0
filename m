From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Oct 2009 23:37:06 +0100
Subject: [git pull] iop3xx fixes for 2.6.31-rc7
In-Reply-To: <EFCC3EA6-5150-4A12-BBF2-9C8147B83820@iki.fi>
References: <1250633811.25922.10.camel@dwillia2-linux.ch.intel.com>
	<EFCC3EA6-5150-4A12-BBF2-9C8147B83820@iki.fi>
Message-ID: <20091002223706.GA31132@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2009 at 10:45:51AM +0300, Aaro Koskinen wrote:
> Hi,
>
> On 19.8.2009, at 1.16, Dan Williams wrote:
>> Hi Russell, please pull from:
>>
>> 	git://git.kernel.org/pub/scm/linux/kernel/git/djbw/xscaleiop.git  
>> fixes
>>
>> ...to receive:
>>
>> Aaro Koskinen (1):
>>       iop3xx: ATU and PCI memory configuration corrected
>>
>> Dan Williams (1):
>>       iop33x: update defconfig (default atu to on)
>>
>> Julia Lawall (1):
>>       arch/arm/plat-iop: Use DIV_ROUND_CLOSEST
>
> Any chance to get these into .32-rc series?

Now pulled and pushed back out for Linus to pick up.
