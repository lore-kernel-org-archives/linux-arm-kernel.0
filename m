From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 10:07:37 +0000
Subject: [PATCH 0/3] arm64: Use pte manipulation functions for THP
In-Reply-To: <20140212094338.GA11325@linaro.org>
References: <1391696171-8922-1-git-send-email-steve.capper@linaro.org>
 <20140212094338.GA11325@linaro.org>
Message-ID: <20140212100736.GA13441@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 09:43:39AM +0000, Steve Capper wrote:
> On Thu, Feb 06, 2014 at 02:16:08PM +0000, Steve Capper wrote:
> > This series replaces the Transparent HugePage pmd manipulation
> > functions with calls to the standard pte functions. This allows the THP
> > code to take advantage of the new PTE_WRITE logic, and provides better
> > parity with the HugeTLB code (which already uses the pte functions).
> > 
> > Testing was done on the Fast Model with LTP THP tests, and the 3.14-rc1
> > kernel was used.
> 
> Hi,
> Does this series look reasonable?

I was waiting for the corresponding arch/arm/ changes.

Will
