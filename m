From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Jan 2010 11:06:34 +0000
Subject: Cortex-m3 Kernel Port.
In-Reply-To: <aecf5e531001242215g5f2c42c8q458637f024a40521@mail.gmail.com>
References: <aecf5e531001242215g5f2c42c8q458637f024a40521@mail.gmail.com>
Message-ID: <1264417594.6275.5.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-01-25 at 06:15 +0000, Sasa Sasa wrote:
> What is the status of the cortex-m3 kernel port ? Is it merged to
> mailine ?

No and I wasn't planning to unless there are more people using it to be
worth the maintenance effort (the Cortex-M3 platforms I've seen have too
little RAM to be able to run Linux).

> I cannot find the sources anymore on the links provided at
> http://www.linux-arm.org/LinuxKernel/LinuxM3
> (has it moved somewhere else....where ?)

The page is a bit out of date and needs the links updated. I included
the Cortex-M3 in the ARM Ltd's stable Linux kernel release, currently
based on 2.6.28:

http://www.linux-arm.org/git?p=linux-2.6-stable.git;a=summary

The shortlog link shows 6 Cortex-M3 related patches, though two of them
are specific to ARM Ltd's MPS board.

I plan to update these patches and the stable Linux kernel above to
2.6.33 in March.

-- 
Catalin
