From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Feb 2012 11:21:20 +0000
Subject: [PATCHv2 1/6] ARM: ftrace: remove useless memory checks
In-Reply-To: <20120224164821.GA22856@debian>
References: <1327757725-10114-1-git-send-email-rabin@rab.in>
 <1327757725-10114-2-git-send-email-rabin@rab.in>
 <20120220161601.GH26840@n2100.arm.linux.org.uk>
 <20120222141317.GB9031@debian> <20120222212821.GE7041@n2100.arm.linux.org.uk>
 <20120224164821.GA22856@debian>
Message-ID: <20120227112119.GT22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 10:18:21PM +0530, Rabin Vincent wrote:
> Replacing the original is OK with me, new patch below.  Note that "ARM:
> ftrace: use canonical Thumb-2 wide instruction format" will need to be
> manually rebased on top of it since there is a change in the context.

Ok, please put this in the patch system, thanks.
