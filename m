From: schwarzb@ipms.fraunhofer.de (Markus Schwarzenberg)
Date: Wed, 28 Oct 2009 16:49:17 +0100
Subject: smdk6400/S3C6400 failure on execution of init process
In-Reply-To: <20091028153010.GE8096@trinity.fluff.org>
References: <20091028162037.22f2cb22@linpcd55>
	<20091028153010.GE8096@trinity.fluff.org>
Message-ID: <20091028164917.1bbaef4f@linpcd55>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2009 15:30:17 +0000 Ben Dooks <ben-linux@fluff.org> wrote:

> On Wed, Oct 28, 2009 at 04:20:37PM +0100, Markus Schwarzenberg wrote:
> > 
> > booting linux-2.6.32-rc5 on our smdk6400 (S3C6400) fails somewhere in/after 
> > the asm call in arch/arm/kernel/sys_arm.c:kernel_execve, when the init 
> > process is to be run.
> 
> Which is the last kernel version that ran this ok?

None. 2.6.32-rc5 is basically the first we try. (after no success with 
2.6.31-rc6)

 
> Does the kernel have vfp support compiled in?

No.

--
Markus Schwarzenberg
