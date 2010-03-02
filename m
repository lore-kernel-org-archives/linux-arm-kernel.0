From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 02 Mar 2010 15:29:05 -0800
Subject: board/device file names, and machine names
In-Reply-To: <a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<a55d774e1003021456id57a19eud4ca5752ba91d72d@mail.gmail.com>
Message-ID: <1267572545.8759.121.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-02 at 14:56 -0800, Brian Swetland wrote:

> 
> We would, of course, prefer to keep the board named mahimahi for all
> the reasons that have been mentioned in various previous discussions
> around trout, etc:
> 1. This was the name used during development for the platform.

Yeah, but HTC used a totally different name .. So why is your any more
important than their name?

Neither name has been used in mass marketing.

> 2. This is the name the bootloader uses and the production bootloader
> passes module parameters, etc under this name

Isn't this something Android specific tho? (you could reflash the
bootloader too can't you?)

> 3. This is the name the production userspace build for these phones
> uses to identify the specific hardware and locate some features.

How is this connected with the kernel? These devices can be reflashed
can't they?

> 4. The Kconfig description provides a reasonable place to put more
> expansive description of the various enduser visible product names.

Your not looking at it from the developers point of view .. Your
assuming your team does coding, and everyone else just uses the code .. 
Which I don't think is what's going to happen.

> 5. My understanding has always been that MACH_* identifies a
> particular board which may be instantiated in a number of products
> 6. I'm still unconvinced that a machine name like "mahimahi" is any
> more or less confusing than any other common machine name for an ARM
> board, which tend to be codenames, strange alphanumeric designators,
> or combinations of the two.

It's like I said above, no one knows what mahimahi is. Eveyone knows
what nexus one is.

> This seems like an unforunate issue to bikeshed about, and by
> insisting on renaming the board names, more hurdles are put up between
> the (often competing, at least for our time) goals of "going to
> mainline" and "maintaining an up to date tree that works on production
> hardware without regression".

This is really a classic kind of issue .. If you work with us (i.e. the
community) , then your code goes into the kernel. If you ignore us, then
your code usually doesn't go in ..

I want your code to go in, but I also want you to work with us.

I'm not insisting anything right now, I'm just getting a wider audience
to review the issue.

Daniel
