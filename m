From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 3 Oct 2013 09:25:19 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <B674A07C-F8FE-4F4D-BB0A-87D5A50852D0@codeaurora.org>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <20131003152715.GA15931@kroah.com>
 <B674A07C-F8FE-4F4D-BB0A-87D5A50852D0@codeaurora.org>
Message-ID: <20131003162519.GA25042@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 11:21:10AM -0500, Kumar Gala wrote:
> 
> On Oct 3, 2013, at 10:27 AM, Greg Kroah-Hartman wrote:
> 
> > On Thu, Oct 03, 2013 at 09:45:38AM -0500, Kumar Gala wrote:
> >> As we look at upstreaming more support for the Qualcomm MSM SoCs there
> >> are a number of drivers or library like routines that are unique to
> >> the MSM platform, we are thinking that putting them under:
> >> 
> >> drivers/platform/qcom/
> > 
> > What type of drivers are these?  Shouldn't they really go under the
> > specific driver type directory instead?
> 
> If there isn't an existing driver/ dir for this I dont see how it can go there, I'm not also not really a fan of trying to artificial put something that is highly SoC specific into something generic of this nature.

Loose a line-wrap somewhere?...

Anyway, you didn't answer my question, so why do I need to answer yours?

snarkily,

greg k-h
