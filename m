From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Thu, 14 Feb 2013 14:26:35 +0000
Subject: [PATCH] arm64: fix invocation of restore_altstack
In-Reply-To: <20130214133552.GB25537@e106331-lin.cambridge.arm.com>
References: <20130214133552.GB25537@e106331-lin.cambridge.arm.com>
Message-ID: <20130214142635.GT4503@ZenIV.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 01:35:52PM +0000, Mark Rutland wrote:
> Hello,
> 
> I noticed the following issue while attempting to build an arm64 kernel from
> next-20130214, and it still seems to be present in signal/for-next and
> signal/arch-arm64.
> 
> It looks to be a trivial typo.

Thanks; folded and pushed.
