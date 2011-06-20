From: jkosina@suse.cz (Jiri Kosina)
Date: Mon, 20 Jun 2011 16:09:32 +0200 (CEST)
Subject: [PATCH][Trivial] S3C2410 bluetooth: Remove duplicate linux/leds.h
	include
In-Reply-To: <1308566964.13261.14.camel@vivanov>
References: <alpine.LNX.2.00.1106201035590.18991@swampdragon.chaosbits.net>
	<4DFF1AA5.80508@ru.mvista.com>
	<alpine.LNX.2.00.1106201232530.18991@swampdragon.chaosbits.net>
	<1308566964.13261.14.camel@vivanov>
Message-ID: <alpine.LNX.2.00.1106201608460.11049@pobox.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 20 Jun 2011, Vitaliy Ivanov wrote:

> Giri,
> 
> I would still recommend to use the following patch as it corrects many 
> other places for trivial includes duplication. Also I was the first who 
> sent it:).

Unfortunately I haven't been copied on it.

> --
> From: Vitaliy Ivanov <vitalivanov@gmail.com>
> 
> Many stupid corrections of duplicated includes based on the output of scripts/checkincludes.pl.
> 
> Signed-off-by: Vitaliy Ivanov <vitalivanov@gmail.com>

I have applied it, and after performing build tests I will be pushing it 
out.

-- 
Jiri Kosina
SUSE Labs
