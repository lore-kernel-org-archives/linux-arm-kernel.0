From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Thu, 12 May 2011 14:14:57 +0200 (CEST)
Subject: [PATCH] [media] at91: add Atmel Image Sensor Interface (ISI)
	support
In-Reply-To: <20110512114530.GE18952@game.jcrosoft.org>
References: <1305186138-5656-1-git-send-email-josh.wu@atmel.com>
	<20110512114530.GE18952@game.jcrosoft.org>
Message-ID: <Pine.LNX.4.64.1105121413220.24486@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 12 May 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:

[snip]

> > +	if (0 == *nbuffers)
> please invert the test

Don't think this is required by CodingStyle or anything like that. If it 
were, you'd have to revamp half of the kernel.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
