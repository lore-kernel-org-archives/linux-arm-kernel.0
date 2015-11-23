From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 23 Nov 2015 09:21:02 +0100
Subject: [PATCH v8 6/8] input: touchscreen: imx25 tcq driver
In-Reply-To: <5650AE5A.5010506@kernel.org>
References: <1447675269-8831-1-git-send-email-mpa@pengutronix.de>
 <1447675269-8831-7-git-send-email-mpa@pengutronix.de>
 <5650AE5A.5010506@kernel.org>
Message-ID: <201511230921.02588.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Saturday 21 November 2015 18:48:10 Jonathan Cameron wrote:
> [...]
> Another personal preference. I'd not bother wrapping these single line
> calls up but rather just make them inline.  They don't in of
> themselves add much to my mind.  Still this one is very much up to you
> as far as I'm concerned.

A matter of taste. Programming bits is more or less hard to understand even if 
we use macros with useful names. So it is me to prefer self explaining 
functions by no cost of code because the compiler will optimise it away.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions ? ? ? ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
