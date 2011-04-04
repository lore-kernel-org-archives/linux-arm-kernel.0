From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 4 Apr 2011 20:47:55 +0300
Subject: [PATCH] pxa2xx_spi: Fix race condition in stop_queue()
In-Reply-To: <BANLkTimBfLF_ef70dYsVDwKCU=fEe_+Z3w@mail.gmail.com>
References: <1300055230-29628-1-git-send-email-anarsoul@gmail.com>
	<201104011303.59668.anarsoul@gmail.com>
	<BANLkTimBfLF_ef70dYsVDwKCU=fEe_+Z3w@mail.gmail.com>
Message-ID: <201104042047.55504.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 April 2011 20:35:14 Mike Frysinger wrote:

> that's fine, i do.  was this patch actually merged ?  or is there a
> new version on the way ?
> -mike

I suspect it's not merged yet. Btw, should I make a patch which fixes all 
drivers, or it's prefferable to make one patch per driver?

Regards
Vasily
