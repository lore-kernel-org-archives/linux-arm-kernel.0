From: bcrl@kvack.org (Benjamin LaHaise)
Date: Thu, 4 Feb 2016 09:08:22 -0500
Subject: linux-next: build failure after merge of the aio tree
In-Reply-To: <20160204135056.GE10826@n2100.arm.linux.org.uk>
References: <20160112164034.0fe945a7@canb.auug.org.au>
 <20160112163835.GD347@kvack.org> <20160127134024.0fababf6@canb.auug.org.au>
 <20160129113056.GP10826@n2100.arm.linux.org.uk>
 <CAMuHMdUy-cqeN8COO4rdpY-mOH+6gth40wB31-edkj8CO5PFCw@mail.gmail.com>
 <20160204131959.6695c7bf@canb.auug.org.au> <20160204134142.GA16315@kvack.org>
 <20160204135056.GE10826@n2100.arm.linux.org.uk>
Message-ID: <20160204140822.GB16315@kvack.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 01:50:56PM +0000, Russell King - ARM Linux wrote:
> > I am still convinced that this is an architecture issue.  Given that 64 bit 
> > values work in the *get_user implementations on other architectures, I see 
> > no reason there should need to be a workaround for this in common code.
> 
> So you're happy to break x86-32 then...

x86-32 works fine.

		-ben
-- 
"Thought is the essence of where you are now."
