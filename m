From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Feb 2012 10:03:51 +0000
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K
 timer is enabled
In-Reply-To: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
References: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20120211100351.GB13587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 11, 2012 at 04:31:25PM +0800, Ming Lei wrote:
> With 32K gp timer, tick can be driven and system can run well, so
> allow MPU local timer to be disabled if someone requires it, otherwise
> MPU local timer is always chosen as the default clock_event_device.

The point being?

What if you want to use NO_HZ?
