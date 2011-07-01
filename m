From: will.deacon@arm.com (Will Deacon)
Date: Fri, 1 Jul 2011 11:10:28 +0100
Subject: [PATCH v3 00/40] ARM: mm: Add generic macros for declaring
	various CPU structs
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20110701101027.GA976@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Jun 23, 2011 at 06:50:08PM +0100, Dave Martin wrote:
> This series adds macros for declaring some CPU-related structured
> defined in assembler, and ports the various processors, cache and
> tlb implementations to use the macros.
> 
> Where multiple proc_info structures are defined by a single source
> file, the common elements are collapsed out of these by defining
> and invoking an additional local macro for this purpose.
> 
> A primary goal for this series is to introduce no API or binary
> changes except for fixing the few obvious bugs which became apparent
> when working on the series.
> 
> NOTE: There is an overlap between this series and Will/Pawel's patches
> to include Cortex-A5 support (see
> http://lists.arm.linux.org.uk/lurker/message/20110617.081930.2ed0934d.en.html).
> Will has agreed to merge with my series in his tree so that it can all
> be pulled from there, providing that my series has been accepted by
> the community.

It looks like this has settled down now so I'll pull your arm/proc-macros
branch from git://git.linaro.org/people/dmart/linux-2.6-arm.git into my
tree and rebase the A5/A15 stuff on top of it.

Will
