From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Dec 2011 15:27:34 +0000
Subject: [PATCH 0/4] Add generic ARM ISA condition code check
In-Reply-To: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
References: <20111208173100.7572.9099.stgit@localhost6.localdomain6>
Message-ID: <20111209152734.GG5196@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leif,

On Thu, Dec 08, 2011 at 05:31:33PM +0000, Leif Lindholm wrote:
> There are several locations in the kernel where software needs to
> inspect the condition codes of trapped instructions. The original
> bitmask implementation in the nwfpe code does this in an efficient
> manner. This series breaks this code out of nwfpe/fpopcode.{ch} into
> a standalone file for opcode operations, and contains additional
> patches to kprobes and SWP eumlation to use this interface.

Dave's been posting an opcodes.h which seems to fit in with some of this, so
it's definitely worth you guys syncing up if you haven't already.

Dave - any comments?

Will
