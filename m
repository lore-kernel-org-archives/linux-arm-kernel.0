From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 23 Oct 2013 20:30:42 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023182502.GC32563@obsidianresearch.com>
References: <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <52658EBC.8020800@wwwdotorg.org>
 <alpine.LFD.2.03.1310211632460.1951@syhkavp.arg>
 <20131022093923.GC15640@ulmo.nvidia.com>
 <20131022150426.GF29341@beef>
 <20131022171346.GE4061@obsidianresearch.com>
 <20131023080630.GA14413@netboy>
 <20131023172955.GA17145@obsidianresearch.com>
 <20131023180108.GA23728@roeck-us.net>
 <20131023182502.GC32563@obsidianresearch.com>
Message-ID: <20131023183041.GH5208@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 12:25:02PM -0600, Jason Gunthorpe wrote:

> What they want is one vmlinux/z, and a package of 'stuff' that they
> can assemble a boot image for all hardware out of.

...

> On ARM the package of 'stuff' can very reasonably include dtb. Distro
> scripts can package modules+DTB+vmlinuz into something the bootloader
> can understand. (The next pain point will be to standardize that)
> 
> The DTB doesn't have to be 'outside' the distro/kernel to give users a
> seamless upgrade experience.

How can a distro possibly provide me a DTB?

They don't know what hardware I am using. Only I know that.

Thanks,
Richard
