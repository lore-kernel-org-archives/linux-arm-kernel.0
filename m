From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 5 Apr 2011 00:06:22 +0200
Subject: WARNING: at mm/page_alloc.c
In-Reply-To: <20110404212906.GA984@core.coreip.homeip.net>
References: <20110404132226.GA14806@atrey.karlin.mff.cuni.cz>
	<20110404212906.GA984@core.coreip.homeip.net>
Message-ID: <20110404220622.GA11677@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Maybe if you could post your program we could see what exactly went
> wrong...

Gone trought my code once again and found small typo in sizeof() in
uinput_user_dev initialization.

Sorry for the noise.

-- 
metan
