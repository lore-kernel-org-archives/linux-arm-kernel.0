From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 17 Jun 2014 22:54:49 +0800
Subject: ARM diagnostic register across suspend/resume
In-Reply-To: <20140617143415.GH13808@arm.com>
References: <20140617083117.GD8860@dragon> <20140617095729.GF13020@arm.com>
 <20140617101606.GE23430@n2100.arm.linux.org.uk>
 <20140617102123.GA13808@arm.com>
 <20140617102344.GG23430@n2100.arm.linux.org.uk>
 <20140617102519.GC13808@arm.com> <20140617130333.GE8860@dragon>
 <20140617143415.GH13808@arm.com>
Message-ID: <20140617145448.GH8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 03:34:15PM +0100, Will Deacon wrote:
> The hardware guys got back to me, and I was mistaken (in fact, confused by
> another register). So the diagnostic register on A9 *does* read back with
> the value written to it. You still need to save/restore it across suspend,
> but read-modify-write is the right thing to do everywhere else.

Thanks for the confirmation, Will.

Shawn
