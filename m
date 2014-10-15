From: pavel@denx.de (Pavel Machek)
Date: Wed, 15 Oct 2014 09:48:58 +0200
Subject: [PATCH v3 1/2] socfpga: hotplug: put cpu1 in wfi
In-Reply-To: <1413315219-28885-2-git-send-email-atull@opensource.altera.com>
References: <1413315219-28885-1-git-send-email-atull@opensource.altera.com>
 <1413315219-28885-2-git-send-email-atull@opensource.altera.com>
Message-ID: <20141015074858.GA10720@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2014-10-14 14:33:38, atull at opensource.altera.com wrote:
> From: Alan Tull <atull@opensource.altera.com>
> 
> Use WFI when putting CPU1 to sleep.  Don't hold CPU1 in reset
> since that results in increased power consumption.
> 
> Reset CPU1 briefly during CPU1 bootup.
> 
> This has been tested for hotplug and suspend/resume and results
> in no increased power consumption.
> 
> Signed-off-by: Alan Tull <atull@opensource.altera.com>

Acked-by: Pavel Machek <pavel@denx.de>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
