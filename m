From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Mar 2015 14:00:29 -0700
Subject: [PATCH v3 4/4] arm64: dts: add interrupt-affinity property to
 pmu node for juno
In-Reply-To: <20150327173319.GP1562@arm.com>
References: <1425642851-27450-1-git-send-email-will.deacon@arm.com>
 <1425642851-27450-5-git-send-email-will.deacon@arm.com>
 <20150324150528.GE29342@arm.com> <20150327173319.GP1562@arm.com>
Message-ID: <20150329210029.GE13301@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 27, 2015 at 05:33:19PM +0000, Will Deacon wrote:
> On Tue, Mar 24, 2015 at 03:05:28PM +0000, Will Deacon wrote:
> > [adding arm-soc folks]
> > 
> > Hi Arnd, Olof,
> > 
> > Could you take this Juno .dts patch via arm-soc for 4.1 please? I'll queue
> > the perf code to make use of the new binding, but there's not a strict
> > dependency (the interrupt-affinity property will be ignored by older
> > kernels).
> 
> Gentle ping, although I guess most people were tied up with ELC/ACPI this
> week.
> 
> Happy to resend the patch if necessary.

Yeah, please resend. Getting just a comment on the thread to
arm at kernel.org works to get our attention, but it's awkward to apply
patches that way. Resend and I'll be happy to apply.


-Olof
