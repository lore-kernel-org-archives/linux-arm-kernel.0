From: wade_farnsworth@mentor.com (Wade Farnsworth)
Date: Mon, 20 Feb 2012 08:37:57 -0700
Subject: ARM tracehook support
Message-ID: <4F4268D5.7070103@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

A few months back, Steven Walter posted some patches that implemement 
syscall tracing support for ARM:

http://lists.arm.linux.org.uk/lurker/message/20111129.162812.bd17d9b5.en.html#linux-arm-kernel

I've been working on SystemTap support for ARM, and the tracehook patch 
in particular is interesting in that respect.  With that patch applied, 
it would allow utrace to be supported on ARM, which is necessary for 
userspace stap probes to function properly.

 From what testing I've done, the patches don't appear to be harmful. 
So, I'm wondering what's preventing this from being pushed into 
mainline?  Are there still outstanding issues that need to be addressed? 
  I'd be happy to help solve them if it would help this patch get into 
mainline quicker.

Thanks in advance!

Wade Farnsworth
