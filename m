From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 7 Feb 2013 11:12:06 +0100
Subject: kernel 3.8 make problem
In-Reply-To: <20130206170638.GJ17833@n2100.arm.linux.org.uk>
References: <ttxj4oytvg02pxivwnruketi.1359554350723@email.android.com>
 <20130130150729.4aae5409@armhf> <51093541.3020309@openwrt.org>
 <20130206180305.3bbc2d4d@armhf>
 <20130206170638.GJ17833@n2100.arm.linux.org.uk>
Message-ID: <20130207111206.153df673@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Feb 2013 17:06:38 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Feb 06, 2013 at 06:03:05PM +0100, Jean-Francois Moine wrote:
> > I moved to make 3.82 and also libc6 2.17 (my Cubox runs Debian armhf
> > with kernel 3.8-rc6), and I can now make some programs (with make 2.81,
> > I was getting a seg fault of the child after the first vfork), but I
> > get the same errors when building a kernel. Does anybody have such a
> > problem?
> 
> Are you using a 2G:2G VM split?  If so, don't (really no reason to use
> that on the cubox.)

With 3/1 VM split, you cannot use at least 128Mb.

But, thanks, you are right: 'make' works with 3/1, but not with 2/2 nor 1/3.
The strangest thing is that all other programs seem to work fine.

What is the devil with make?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
