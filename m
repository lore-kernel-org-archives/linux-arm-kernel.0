From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 13 Jun 2012 17:14:20 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <4FD8AC5E.1060804@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD8AC5E.1060804@redhat.com>
Message-ID: <4FD8AE4C.2070804@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2012 05:06 PM, Jon Masters wrote:
> On 06/11/2012 12:52 PM, Gregory CLEMENT wrote:
> 
>> You'll find in this patch set the new version of the initial support for a
>> new family of ARMv7-compatible Marvell SoCs initially submitted by my
>> colleague Thomas Petazzoni. Following the conclusion of the discussion when
>> we submitted our first version we have chosen to add this support for this
>> SoC family in the to support in the arch/arm/mach-mvebu/ directory.
> 
> Pardon my silly question. I know that there's an effort to reconcile the
> two different SoCs so you're picking a neutral name, but what does
> "mvebu" mean, and will you be persistently keeping this name? Our guys
> want to know what this new platform will entail for Fedora support in
> terms of the platform name being used in various non-kernel places.

Hello Jon,

As I explained to Martin
"Mvebu is aimed to be the official name for the all the SOC with device tree
support coming out of Marvell's EBU division. As stated Nicolas Pitre: "One
thing that is common to Orion/Kirkwood/Dove/(insert some Armada flavours
here)/etc though is that they came out of Marvell's EBU division."

[...]

For extensive explanation see the thread starting at this point
http://thread.gmane.org/gmane.linux.ports.arm.kernel/167744/focus=167782.
"

So MVEBU is not only for Armada XP and Armada 370 but also for other
Marvell SOCs such as Kirkwood or Orion for example.


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
+33 602 196 044
