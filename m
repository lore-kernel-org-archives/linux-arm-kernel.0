From: pavel@denx.de (Pavel Machek)
Date: Tue, 9 Sep 2014 16:17:56 +0200
Subject: [GIT PULL 1/2] SOCFPGA updates for 3.18
In-Reply-To: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <20140909141756.GA30100@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Jaehoon Chung (1):
>       ARM: dts: socfpga: unuse the slot-node and deprecate the supports-highspeed for dw-mmc
> 

This patch is a bad idea. It removes support for two mmc cards on a
single controller -- configuration hardware supports and configuration
that allows using u-SD card on mcvevk board.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
