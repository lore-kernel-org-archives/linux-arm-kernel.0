From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 29 Jan 2017 23:52:54 +0200
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <1485726109.30797.5.camel@crowfest.net>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
 <1485723150.30797.1.camel@crowfest.net>
 <20170129210611.k46ey35py3ht3fe7@tarshish>
 <1485726109.30797.5.camel@crowfest.net>
Message-ID: <20170129215253.hwhwsqoulhmjxs55@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michael,

On Sun, Jan 29, 2017 at 01:41:49PM -0800, Michael Zoran wrote:
> On Sun, 2017-01-29 at 23:06 +0200, Baruch Siach wrote:
> > Kernel development is email based. See "Why kernel development still
> > uses? email"[1]. What would you like to see improved?
> 
> No offense to any of the maintainers, but the e-mail system is
> optimized for a very large number of very, very small changes. It isn't
> optimized for large changes.  In a way it tends to discourage any kind
> of big improvements.
> 
> The idea of checking in a very large number of small patches makes
> sense for auditing.  And yes having both isn't totally possible, so I
> don't know really where the line should go between the two.  But taking
> things to one extreme or the other doesn't make sense either.

In extreme cases like the examples below sending email patches doesn't make 
sense, so direct git pulls can be used instead. But these cases are quite 
rare.

Commit 07a8c03f3e0 (ARM: reduce defconfigs) shortstat is:

 177 files changed, 652 insertions(+), 194157 deletions(-)

Commit 607ca46e97 (UAPI: (Scripted) Disintegrate include/linux) shortstat is:

 578 files changed, 32659 insertions(+), 30108 deletions(-)

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
