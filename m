From: cubicool@gmail.com (Jeremy Moles)
Date: Wed, 10 Sep 2014 13:57:33 -0400
Subject: EP93XX / EDB9315A Audio Issues
Message-ID: <5410910D.6060201@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(I'm cross-posting this to the linux-arm-kernel and alsa-devel lists, as 
recommended):

I'm looking for anyone who has successfully used the EP93XX/EDB9315A 
demo board's sound infrastructure. I have been working with Hartley 
Sweeten on patching some DMA coherency mask issues (successfully), and 
while this makes the kernel stop complaining (and allows the userspace 
to "appear" to work) I never actually get any sound out of the machine 
on newer kernels.

I do, however, have an existing (binary-only) 2.6.21 kernel from the 
client where sound _IS_ functional; thus, I know the system can 
POTENTIALLY work, and that the problem is software-based.

At this point, I have a mountain of information I can provide about the 
state of my EDB9315A board, but what I'm really looking for is someone 
to connect with and/or have consult with us to get sound working on 
newer kernels with this board exactly (although other EP93XX boards 
might be similar, I'm so mistrustful of everything at this point I'm 
looking for someone else with this hardware EXACTLY).

I've tried 3.15-3.17, all with the same results. aplay/alsamixer see the 
device, appear to interact with it in a normal fashion (it even 
mutes/unmutes the device every time you touch it), but no sound is ever 
produced. It is possible, of course, the problem is in userspace (I'm 
using a custom Yocto-based image), but I'm doubtful of that.

At any rate, any help would be greatly appreciate, although i realize 
this is fringe hardware. :)
