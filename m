From: viric@viric.name (=?iso-8859-1?Q?Llu=EDs?= Batlle i Rossell)
Date: Sat, 15 Sep 2012 12:51:51 +0200
Subject: Bad traps for unaligned access in STM instruction
In-Reply-To: <20120915104602.GY1943@vicerveza.homeunix.net>
References: <20120915104602.GY1943@vicerveza.homeunix.net>
Message-ID: <20120915105151.GZ1943@vicerveza.homeunix.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 12:46:02PM +0200, Llu?s Batlle i Rossell wrote:
> I'll start looking at the arm traps for unaligned accesses, but maybe someone
> here can give a quick answer.

Ah stupid me, here goes the quick answer. I had mode 'warn', and not
'fixup+warn'. With 'fixup' enabled, all works fine.

I was used to mips, where I think there isn't a 'warn' that doesn't 'fixup'.

Regards,
Llu?s.
