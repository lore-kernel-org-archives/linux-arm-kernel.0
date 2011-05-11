From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 May 2011 20:36:02 +0100
Subject: Fwd: [ARM]crash on 2.6.35.11
In-Reply-To: <BANLkTi=oZ0Mr33rL=QNmzDuaKLNezoKBXg@mail.gmail.com>
References: <BANLkTimLd-qY-OeKqnf2EoTfvAHWQZVchw@mail.gmail.com>
	<BANLkTi=oZ0Mr33rL=QNmzDuaKLNezoKBXg@mail.gmail.com>
Message-ID: <20110511193602.GK5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2011 at 03:46:55PM +0530, naveen yadav wrote:
> Attaching test case
> 
> Dear all,
> 
> We are running linux kernel 2.6.35.11 on Cortex a-8. when I run a
> simple program expect to give oom.
> ?But it crash with following crash log

You need to include the memory layout information - eg, the boot log,
and /proc/iomem.  Also are you using sparsemem?  If so, how is it
configured?
