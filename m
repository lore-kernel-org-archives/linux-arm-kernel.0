From: utx@penguin.cz (Stanislav Brabec)
Date: Wed, 18 Nov 2009 15:38:53 +0100
Subject: 2.6.32-rc7: compile regression on spitz
In-Reply-To: <20091118090100.GA1399@ucw.cz>
References: <20091118090100.GA1399@ucw.cz>
Message-ID: <1258555133.3454.2.camel@hammer.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pavel Machek wrote:
> If CONFIG_AKITA is not set, spitz fails to compile. It worked ok in
> rc5. Fix is one more ifdef...

That was my mistake in 5e0fa3f.

> Signed-off-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Stanislav Brabec <utx@penguin.cz>

-- 
Stanislav Brabec
http://www.penguin.cz/~utx
