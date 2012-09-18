From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Sep 2012 21:25:28 +0100
Subject: Stable branch for 3.7?
In-Reply-To: <50589901.7000301@arm.com>
References: <50589901.7000301@arm.com>
Message-ID: <20120918202528.GX12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 18, 2012 at 04:53:37PM +0100, Marc Zyngier wrote:
> Hi Russell,
> 
> Do you have a stable branch for patches you're queuing for the 3.7 merge
> window? Specially, one containing Dave Martin's opcode series (687e735
> to 806d05c in your for-next branch).
> 
> I'd like to rebase the HYP-mode boot series on top of something stable
> and potentially send you a pull request for that.

I've split the opcode series out from what I had queued in 'misc'
and have published a branch called 'opcodes' via my tree on
ftp.arm.linux.org.uk for this.
