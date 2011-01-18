From: npiggin@gmail.com (Nick Piggin)
Date: Wed, 19 Jan 2011 09:19:59 +1100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <201101181759.32013.maciej.rutecki@gmail.com>
References: <20110111110539.GP24920@pengutronix.de>
	<201101181759.32013.maciej.rutecki@gmail.com>
Message-ID: <AANLkTikC0ZV6pZ7jVmZ5DSrrkPCN4UPn3VY+zM2RWSc6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/19 Maciej Rutecki <maciej.rutecki@gmail.com>:
> I created a Bugzilla entry at
> https://bugzilla.kernel.org/show_bug.cgi?id=27032
> for your bug report, please add your address to the CC list in there, thanks!

Sorry I missed this mail. This bug should have been fixed several
days ago 90dbb77ba48dddb87445d238e84cd137cf97dd98

Thanks for the report, please do again if you see any problems.
