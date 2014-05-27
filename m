From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 27 May 2014 12:38:11 -0400
Subject: [PATCH 2/2] ARM: dts: mvebu: split SolidRun CuBox into variants
In-Reply-To: <5384BDB1.6000107@gmail.com>
References: <1401140009-31505-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1401140009-31505-2-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140527161143.GS8664@titan.lakedaemon.net>
 <5384BDB1.6000107@gmail.com>
Message-ID: <20140527163811.GT8664@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 06:30:41PM +0200, Sebastian Hesselbarth wrote:
...
> About the board specific compatibles, I am not so sure if we should
> keep them at all. "solidrun,cubox" for all three variants should be
> enough. checkpatch is already choking on every unknown compatible it
> sees and documenting each individual board clearly doesn't scale well.

Yeah, I saw that conversation.  I'm inclined to keep the board
compatible strings because they are a useful human readable globally
unique board identifier.  I suggest we fix checkpatch to not barf on the
board compatible strings.

thx,

Jason.
