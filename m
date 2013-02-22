From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Feb 2013 00:29:52 +0000
Subject: [U-Boot] [RFC] Kbuild support for ARM FIT images
In-Reply-To: <5126B1A1.2070703@wwwdotorg.org>
References: <20130221103705.GB17852@n2100.arm.linux.org.uk>
 <51261F38.2030902@ti.com> <20130221134656.GC17852@n2100.arm.linux.org.uk>
 <51262A7A.8040103@ti.com> <alpine.LFD.2.03.1302211144240.6419@syhkavp.arg>
 <20130221182724.GA14329@obsidianresearch.com>
 <alpine.LFD.2.03.1302211423190.6419@syhkavp.arg>
 <20130221211444.GB20114@obsidianresearch.com>
 <alpine.LFD.2.03.1302211624561.6419@syhkavp.arg>
 <5126B1A1.2070703@wwwdotorg.org>
Message-ID: <20130222002952.GH17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 04:45:37PM -0700, Stephen Warren wrote:
> Well they ship x86 CPU firmware updates according to the boot log on one
> of my systems at least...

Correction: CPU microcode updates.  That's updating the microcode in the
CPU which runs the x86 instruction set.  It's done to fix problems
discovered with execution of the CPU instruction set.

That's entirely separate from ACPI or DT blobs provided by the OEM.
