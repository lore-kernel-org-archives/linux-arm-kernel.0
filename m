From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Oct 2013 08:59:43 -0400
Subject: [BUG,REGRESSION] ARM: mvebu: SATA regression w/ 12.0-rc4 kernel
In-Reply-To: <87vc1ahyft.fsf@natisbad.org>
References: <87vc1ahyft.fsf@natisbad.org>
Message-ID: <20131007125943.GA1332@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 06, 2013 at 11:38:46PM +0200, Arnaud Ebalard wrote:
> Hi,
> 
> I was testing some code on my (Armada 370-based) ReadyNAS 102 and got
> the following error while writing something on disk on *3.12-rc4* (also
> happen on -rc3):
> 
...
> I though this was an hardware issue and replaced the disk by another
> one with an already installed system (Debian armel for the former,
> Debian armhf for the latter). After some minutes, the same kind of
> problem occured. When asking smartctl, both disks have a PASSED
> status. I rebooted on a 3.11.4 kernel and never got the issue.

could you run a git bisect so that we can nail it down to a specific
commit?

thx,

Jason.
