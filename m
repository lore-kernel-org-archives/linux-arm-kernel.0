From: imre.deak@nokia.com (Imre Deak)
Date: Mon, 28 Sep 2009 14:01:58 +0300
Subject: [PATCH] ARM: add warning for invalid kernel page faults
In-Reply-To: <20090928102710.GG6715@n2100.arm.linux.org.uk>
References: <20090928092919.GA30271@localhost>
	<1254131304-32057-1-git-send-email-imre.deak@nokia.com>
	<20090928095516.GB6715@n2100.arm.linux.org.uk>
	<20090928100048.GC30271@localhost>
	<20090928100442.GD6715@n2100.arm.linux.org.uk>
	<20090928101625.GE30271@localhost>
	<20090928102710.GG6715@n2100.arm.linux.org.uk>
Message-ID: <20090928110158.GG30271@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2009 at 12:27:10PM +0200, ext Russell King - ARM Linux wrote:
> [...]
>
> Now you're talking about different code - the bit I quoted was what was
> in your submitted patch, without deletion of intervening lines.  There
> was no else clause in your patch.
> 
> Please, go back and look at your original patch.

Ah, sorry. Missed that line when rebasing. I'll send an updated one.

--Imre
