From: cbz@baozis.org (Chen Baozi)
Date: Mon, 25 May 2015 13:33:46 +0800
Subject: Hibernation on ARM64
In-Reply-To: <20150522110218.GC5623@red-moon>
References: <CAMxMOAtMw3jnyrvn46m0ZeiwtWjRRZ-i21N5+riwn-3qei+szg@mail.gmail.com>
 <20150522110218.GC5623@red-moon>
Message-ID: <20150525053346.GB17561@cbz-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On Fri, May 22, 2015 at 12:02:18PM +0100, Lorenzo Pieralisi wrote:
> Hi Christian,
> 
> On Thu, May 21, 2015 at 07:34:06PM +0100, Christian S. Perone wrote:
> > Hello, I haven't found any information, road map or something like
> > that for the hibernation support for ARM64, does anyone knows if there
> > is something planned to support this in near future ?
> 
> Adding arch support for hibernation to arm64 should be fairly simple,
> it is not top priority at the moment simply because there are not
> compelling use-cases (on the PM side most features revolve around
> CPUidle and suspend-to-idle and S2R).
> 
> To answer your question, yes I have planned to support it, I just
> do not want to add it to the kernel for no particular reason, if there
> are compelling requirements (I guess you are asking for a specific
> reason) it can be done fairly quickly.
> 

I am also looking forward the hibernation support on arm64. Thanks for
the information.

Could you please CCed me the hiberation patches when you send them to
list. I can help test it. :-)

Cheers,

Baozi.
