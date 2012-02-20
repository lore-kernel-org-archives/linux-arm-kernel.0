From: will.deacon@arm.com (Will Deacon)
Date: Mon, 20 Feb 2012 15:47:48 +0000
Subject: ARM tracehook support
In-Reply-To: <4F4268D5.7070103@mentor.com>
References: <4F4268D5.7070103@mentor.com>
Message-ID: <20120220154748.GG25462@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 03:37:57PM +0000, Wade Farnsworth wrote:
> Hi all,

Hello Wade,

> A few months back, Steven Walter posted some patches that implemement 
> syscall tracing support for ARM:
> 
> http://lists.arm.linux.org.uk/lurker/message/20111129.162812.bd17d9b5.en.html#linux-arm-kernel
> 
> I've been working on SystemTap support for ARM, and the tracehook patch 
> in particular is interesting in that respect.  With that patch applied, 
> it would allow utrace to be supported on ARM, which is necessary for 
> userspace stap probes to function properly.
> 
>  From what testing I've done, the patches don't appear to be harmful. 
> So, I'm wondering what's preventing this from being pushed into 
> mainline?  Are there still outstanding issues that need to be addressed? 

Yup, I posted some questions here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-December/074802.html

but I haven't heard anything from Steven since then, so it's all stalled at
the moment. They'll also obviously need rebasing onto latest mainline,
although that shouldn't be too hard since they're still fairly recent.

Will
