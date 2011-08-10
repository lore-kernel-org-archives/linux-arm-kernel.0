From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Aug 2011 01:11:58 -0600 (MDT)
Subject: How to handle named resources with DT?
In-Reply-To: <20110810015214.GD23511@yookeroo.fritz.box>
References: <4E4166F0.9050401@ti.com>
	<CACxGe6tbEW1EZhqXy78EZVM_sQLH0Qbr7QOzbgbsKBRn1FtVrg@mail.gmail.com>
	<4E4172A8.3030101@ti.com> <4E417BD5.8080409@freescale.com>
	<20110809205723.GE11568@ponder.secretlab.ca>
	<4E41A1B9.1060400@ti.com>
	<20110809211747.GJ11568@ponder.secretlab.ca> <4E41AA43.1000506@ti.com>
	<20110809214905.GK11568@ponder.secretlab.ca>
	<4E41AC5C.20301@ti.com> <20110810015214.GD23511@yookeroo.fritz.box>
Message-ID: <alpine.DEB.2.00.1108100104150.12674@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Aug 2011, David Gibson wrote:

> Of course, the problem with reg-names is that it will be ignored by
> older OSes, and so 'reg' must still be in the correct order.

Most ARM SoC Linux ports aren't using DT now, so there isn't really an 
older OS case here.  Might as well try to get something implemented in a 
clean way while there's still some chance for it.

A more persuasive case could probably be made about DT bootloader-related 
issues.  Those would have to be converted to use reg-names, also.


- Paul
