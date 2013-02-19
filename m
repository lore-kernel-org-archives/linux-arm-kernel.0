From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Tue, 19 Feb 2013 03:47:50 -0500
Subject: [patch 1/2] kcmp: Make it to depend on CONFIG_KCMP
In-Reply-To: <20130219065210.030802820@openvz.org>
References: <20130219064800.719149796@openvz.org>
 <20130219065210.030802820@openvz.org>
Message-ID: <51233C36.4020804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(2/19/13 1:48 AM), Cyrill Gorcunov wrote:
> Since kcmp syscall has been implemented (initially on
> x86 architecture) a number of other archs wire it up
> as well: xtensa, sparc, sh, s390, mips, microblaze,
> m68k (not taking into account those who uses
> <asm-generic/unistd.h> for syscall numbers
> definitions).
> 
> But the Makefile, which turns kcmp.o generation on
> still depends on former config-x86. Thus get rid
> of this limitation and make kcmp.o depend on CONFIG_KCMP
> option.

Acked-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
