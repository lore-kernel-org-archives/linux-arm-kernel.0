From: rusty@rustcorp.com.au (Rusty Russell)
Date: Mon, 16 Aug 2010 15:17:15 +0930
Subject: The patch of ARM Lguest
In-Reply-To: <SNT105-W574D2F0E65679738D280C884900@phx.gbl>
References: <SNT105-W15A03E7C3F4603D985360D84A30@phx.gbl>
	<201007301102.01369.rusty@rustcorp.com.au>
	<SNT105-W574D2F0E65679738D280C884900@phx.gbl>
Message-ID: <201008161517.15979.rusty@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 5 Aug 2010 11:17:00 pm LiMing wrote:
> Hi Rusty,
> 
> The attachments are the patch of ARM Lguest and the file for /dev/vda.
> 
> patch-2.6.33.6.ARMLGUEST is the patch for linux.2.6.33.6.

Hi Mingli!

Wow, this is a big patch.

Ok, I have no way of testing this code, but I've CC'd some people who
might be able to, and offer sage advice.

I've put your code in a git tree to work on it, and for others to see:

	git clone git://git.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6.git
	git checkout arm-lguest

This is my plan from here: I have started, but please send patches
against the git tree above.

1) Remove all the extra whitespace (done)
2) Remove as many #ifdefs as we can.
3) Split off general arm changes.
4) Split into multiple patches for review.
5) Get some people who know ARM to review it.
  5a) Take review feedback and add more patches.
6) Clean up common code with x86 so we can combine.
   (esp. the launcher code)
7) Clean git tree into a nice patch series.
8) Forward port to latest kernel for merge.
9) Merge it!

> In the source code,  I "borrowed" many excellent souce code comments for X86 Lguest.
> I tried my best to write my own comments,  but these comments are still very poorly.
> Please help me with it.   

I will certainly do this, too.

> SORRY FOR TROUBLING YOU.

You can trouble me as much as you want!!

Thanks!
Rusty,
