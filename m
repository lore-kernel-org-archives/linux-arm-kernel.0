From: timur@codeaurora.org (Timur Tabi)
Date: Tue, 04 Mar 2014 07:20:55 -0600
Subject: [PATCH 3/5] documentation/iommu: update description of ARM System
 MMU binding
In-Reply-To: <20140304100837.GB8766@mudshark.cambridge.arm.com>
References: <1393002992-24561-1-git-send-email-will.deacon@arm.com>
 <1393002992-24561-4-git-send-email-will.deacon@arm.com>
 <CAOZdJXUfAygZqw9s5qOECLjyo=B0VaD29iesbWzDeMbbyVTgqg@mail.gmail.com>
 <20140228162114.GA30996@mudshark.cambridge.arm.com>
 <5310C253.40804@codeaurora.org>
 <20140304100837.GB8766@mudshark.cambridge.arm.com>
Message-ID: <5315D337.5020909@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon wrote:
> I don't agree. We're making sensible use of a vendor prefix to isolate
> errata workarounds. The description clearly states that the implementation
> is buggy.

Yeah, but I'm disappointed that the patch doesn't explain the exact bug 
that necessitates the property.  I think that's an important clue for 
others to determine whether they would ever need this work-around.

> Given that there aren't any Calxeda engineers left working on this stuff,
> I'm heavily inclined to leave this patch as-is.

Fair enough.
