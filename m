From: metan@ucw.cz (Cyril Hrubis)
Date: Mon, 6 Jun 2011 15:05:48 +0200
Subject: Disable CF during suspend
In-Reply-To: <20110521094326.GB26323@elf.ucw.cz>
References: <20110521094326.GB26323@elf.ucw.cz>
Message-ID: <20110606130548.GA4966@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Disable SPITZ_SCP_CF_POWER during suspend. Otherwise it eats battery,
> fast. Thanks to Stanislav Brabec.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Works on the top of the 3.0-rc2 on my spitz.

Acked-by: Cyril Hrubis <metan@ucw.cz>

-- 
metan
