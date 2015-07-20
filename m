From: jbe@pengutronix.de (Juergen Borleis)
Date: Mon, 20 Jul 2015 15:18:58 +0200
Subject: [PATCH v3] serial: mxs-auart: keep the AUART unit in reset state
 when not in use
In-Reply-To: <55ACF0E5.6040107@hurleysoftware.com>
References: <1437032458-8577-1-git-send-email-jbe@pengutronix.de>
 <201507201004.02646.jbe@pengutronix.de> <55ACF0E5.6040107@hurleysoftware.com>
Message-ID: <201507201518.58720.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Monday 20 July 2015 15:00:21 Peter Hurley wrote:
> [...]
> > mxs_auart_reset() is a bad name from the beginning. But I just wanted to
> > keep this change small and only change things that are really required. I
> > will try with a V4.
>
> ISTM this should be split into 2 or 3 separate patches:
> 1. Rename mxs_auart_reset()
> 2. Fix stale rx on re-open
> 3. Reset @ probe

Okay.

Regards,
Juergen

-- 
Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?| Juergen Borleis ? ? ? ? ? ? |
Industrial Linux Solutions ? ? ? ? ? ? ? ? ? ?| http://www.pengutronix.de/ ?|
