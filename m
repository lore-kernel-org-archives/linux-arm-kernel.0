From: will.deacon@arm.com (Will Deacon)
Date: Fri, 01 Apr 2011 18:27:23 +0100
Subject: accessing vfpinstr macros from outside vfp directory
In-Reply-To: <4D924966.2050707@codeaurora.org>
References: <4D924966.2050707@codeaurora.org>
Message-ID: <1301678843.17592.5.camel@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil,

On Tue, 2011-03-29 at 22:04 +0100, Neil Leeder wrote:
> Any opinions on what would be the best thing to do here? Choices appear to be:
> 
> 1) allow the relative include path of ../vfp/vfpinstr.h
> 2) move the definitions of fmrx, fmxr from vfp/vfpinstr.h to include/asm/vfp.h
> 3) move vfp/vfpinstr.h to include/asm
> 4) other...?
> 
> If it helps, I can create a patch for whichever is considered the preferred solution.
> 

I personally don't find option (1) that offensive - Bryan seemed to
differ though so perhaps option (2) would keep him happy?

I don't think option (3) is sensible given that the majority of the
header file is private to /vfp.

Will
