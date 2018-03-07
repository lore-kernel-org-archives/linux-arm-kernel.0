From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 7 Mar 2018 23:11:24 +0100
Subject: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
In-Reply-To: <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180306124002.GA13950@amd>
 <33bf6563-b220-7ff9-8b04-84e9bd781b3f@linux.intel.com>
Message-ID: <20180307221124.GD10438@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> >Are these SoCs x86-based?
> 
> Yes, these are ARM SoCs. Please see Andrew's answer as well.

Understood, thanks.

> >>+	Read sampling point selection. The whole period of a bit time will be
> >>+	divided into 16 time frames. This value will determine which time frame
> >>+	this controller will sample PECI signal for data read back. Usually in
> >>+	the middle of a bit time is the best.
> >
> >English? "This value will determine when this controller"?
> >
> 
> Could I change it like below?:
> 
> "This value will determine in which time frame this controller samples PECI
> signal for data read back"

I guess... I'm not native speaker, I guess this could be improved some
more.

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/766a0748/attachment.sig>
