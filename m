From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Nov 2015 11:22:46 +0000
Subject: [PATCH 0/7] Various touchscreens: Support axis inversion /
 swapping / extra gpios
In-Reply-To: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
References: <1448018233-27824-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151120112245.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 12:17:06PM +0100, Hans de Goede wrote:
> This patch-set extends the of_touchscreen.c helpers to (optionally) also
> deal with axis inversion / swapping, and patches a bunch of drivers to use
> this new functionality.

What's wrong with using tslib?  tslib supports axis transformations in
userspace via a set of filters.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
