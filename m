From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 21 Oct 2014 13:15:44 +0200
Subject: [PATCH v2 0/5] Add Spreadtrum Sharkl Platform support
In-Reply-To: <1413539665-11484-1-git-send-email-chunyan.zhang@spreadtrum.com>
References: <sprd-1017-v2>
 <1413539665-11484-1-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20141021111544.GA25909@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Sharkl Platform is nominated as a SoC infrastructure that supports 4G/3G/2G
> standards based on ARMv8 multiple core architecture.Now we have only one
> SoC(Sharkl3) based on this Platform in developing.

Does this mean that UMTS/GSM is going to be handled on main CPU on
your platform? Or do you still rely on DSP with specialized OS to
provide UMTS/GSM?

Thanks,
									Pavel

>   Documentation: DT: Renamed of-serial.txt to 8250.txt

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
