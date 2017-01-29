From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 29 Jan 2017 21:30:13 +0100
Subject: [PATCH v5 5/8] clocksource/drivers/rockchip_timer: split bc_timer
 into rk_timer and rk_clock_event_device
In-Reply-To: <14EAE124-D504-4480-A6D4-EB7EFFC3C561@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
 <3890508.0j97LNriXL@diego> <14EAE124-D504-4480-A6D4-EB7EFFC3C561@gmail.com>
Message-ID: <3616490.5RPja2j5kp@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Am Dienstag, 24. Januar 2017, 18:16:20 CET schrieb Alexander Kochetkov:
> > 24 ???. 2017 ?., ? 18:02, Heiko St?bner <heiko@sntech.de> ???????(?):
> > 
> > Please don't add Reviewed-by tags without explicit mention of them by
> > reviewers. (Also it's spelled wrong).
> > 
> > I haven't looked that deeply into the driver itself and the changes made
> > to
> > feel comfortable with a "Reviewed-by".
> 
> Than I posted another linux code I was asked to add such tags (and others)
> to add credits to people.
> 
> Sorry for that.

no problem. In general people reviewing patches will respond to the patch with 
tags they are comfortable with being added. And a Reviewed-by is a pretty 
strong tag, indicating that some thought went into reviewing a specific patch, 
which I hadn't done with my cursory glance at the time :-)

Heiko
