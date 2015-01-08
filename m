From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 8 Jan 2015 09:16:55 +0100
Subject: [PATCH 0/8] Atmel System Timer cleanups
In-Reply-To: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20150108091655.0dfebcff@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Mon,  5 Jan 2015 13:06:37 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> This patch sets cleans up the system timer driver.
> 
> The main goal is to get rid of the mach/ headers dependency. At the same time,
> it introduces proper probing and locking (using a regmap) for the watchdog
> driver.

Thanks for this rework!

You can add my:

Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
