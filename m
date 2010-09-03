From: Matthieu.Moy@grenoble-inp.fr (Matthieu Moy)
Date: Fri, 03 Sep 2010 21:34:02 +0200
Subject: [BUG?] rename patch accepted with --dry-run,
	rejected without (Re: [PATCH V3] arm & sh: factorised duplicated
	clkdev.c)
In-Reply-To: <20100903192907.GA2978@n2100.arm.linux.org.uk> (Russell King's
	message of "Fri\, 3 Sep 2010 20\:29\:07 +0100")
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
	<20100903184351.GC2341@burratino>
	<20100903192907.GA2978@n2100.arm.linux.org.uk>
Message-ID: <vpqr5habp05.fsf@bauges.imag.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> git patches include additional metadata for renaming files, which gnu patch
> will not understand.
>
> If you want GNU patch compatible diffs, don't use -C or -M when generating
> patches out of git.

Fyi: actually, GNU patch will support git-style patches in the next
version according to

http://savannah.gnu.org/forum/forum.php?forum_id=6320

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
