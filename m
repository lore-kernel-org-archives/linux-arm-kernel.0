From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 08:22:43 +0000
Subject: Query about loops_per_jiffy
In-Reply-To: <tencent_5CA6CD330328846756327199@qq.com>
References: <tencent_5CA6CD330328846756327199@qq.com>
Message-ID: <20100119082243.GA23800@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 03:42:53PM +0800, ??? wrote:
> Hi, oldhands:)
>      
> I have a question about how loops_per_jiffy converted to BogoMips, 
> 
> loops_per_jiffy * HZ  <-----------  that's number of instructions CPU executes in a second
> BogoMips <-------------------------- Millions of instructions CPU executes in a second

No.  The clue is in "Bogo" part of the name.
