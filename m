From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 12 Jun 2012 09:35:58 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FD658C2.4030503@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD658C2.4030503@redhat.com>
Message-ID: <4FD6F15E.4080000@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 10:44 PM, David Marlin wrote:
> 
> I noticed that you are using mach-mvebu in these patches.  I have seen 
> these machines referred to as 'armada', 'axp', 'armadaxp', etc.  Will 
> 'mvebu' be the official machine name to use for these systems?  I'm 
> looking for a 'name' to identify the common kernel for these systems. 
> For reference, the names of the ARM kernels we are currently building in 
> Fedora include: 'highbank', 'imx', 'kirkwood', 'omap', and 'tegra'.
> 
> 
> Thank you,
> 
> d.marlin
> ===========
> 

Hello David,

Mvebu is aimed to be the official name for the all the SOC with device tree
support coming out of Marvell's EBU division. As stated Nicolas Pitre: "One
thing that is common to Orion/Kirkwood/Dove/(insert some Armada flavours
here)/etc though is that they came out of Marvell's EBU division."

For the beginning only Armada XP and Armada 370 are in this directory but as
son as the other Marvell architectures will be converted to device tree they
will be moved to mach-mvebu.

For extensive explanation see the thread starting at this point
http://thread.gmane.org/gmane.linux.ports.arm.kernel/167744/focus=167782.


> 
> Gregory CLEMENT wrote:
>> Arnd, Olof,
>>
>> You'll find in this patch set the new version of the initial support for a
>> new family of ARMv7-compatible Marvell SoCs initially submitted by my
>> colleague Thomas Petazzoni. Following the conclusion of the discussion when
>> we submitted our first version we have chosen to add this support for this
>> SoC family in the to support in the arch/arm/mach-mvebu/ directory.
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
