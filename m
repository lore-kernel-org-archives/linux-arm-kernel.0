From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 26 May 2010 23:49:55 -0400 (EDT)
Subject: [PATCH] sa1111: Prevent deadlock in resume path
In-Reply-To: <201005270035.54509.marek.vasut@gmail.com>
References: <1274901104-22133-1-git-send-email-marek.vasut@gmail.com>
	<201005262352.34052.marek.vasut@gmail.com>
	<20100526222530.GD16418@n2100.arm.linux.org.uk>
	<201005270035.54509.marek.vasut@gmail.com>
Message-ID: <alpine.LFD.2.00.1005262306080.24526@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 May 2010, Marek Vasut wrote:

> Dne ?t 27. kv?tna 2010 00:25:30 Russell King - ARM Linux napsal(a):
> > Mine is that I'm dreadful at dealing with patches in email.  Unless I
> > deal with a message at the point I've read it, it basically doesn't
> > exist. 
> 
> Why don't you set up a mailbox for that ? You read the emails anyway and you can 
> drop the patches you Ack into that mailbox ... then run git am on that once in a 
> while.

Marek, let me give you some bit of wisdom.

Russell's patch system existed way before git was created.  It works 
quite well for random patches.  He even created custom scripts to 
extract patches from his system and stuff them into git.  So if he went 
through such trouble instead of relying on the standard 'git am' tool 
with a patch mailbox then there must be a reason, even if that reason 
makes sense only to him.

The impact on you (and I) is rather minimal.  The process is indeed 
documented at length on his website but the actual operation is not much 
different from posting the patch to this mailing list.  And I'm glad to 
make my own life a tiny bit more complicated due to having to email the 
same patch twice (once here and once to the patch system) if that makes 
a big difference to Russell's life.

If you do have a real problem with that system, then just create your 
own git tree and ask RMK to pull it.  That has worked quite well too, 
especially for large patch series.

So please just accept that the ARM process is odd and deal with it.  
The day you end up maintaining a body of code with people routing their 
patches through you then it will be your turn to set the rules for them.


Nicolas
