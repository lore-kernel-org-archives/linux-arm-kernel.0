From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Mar 2015 19:02:04 +0000
Subject: [PATCH] ARM: dts: hummingboard: enable pcf8523 rtc for i2eX
In-Reply-To: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
References: <1425322206-30115-1-git-send-email-mporter@konsulko.com>
Message-ID: <20150302190204.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 01:50:06PM -0500, Matt Porter wrote:
> The PCF8523 RTC is populated on the i2eX boards so
> enable the i2c1 controller and enable the device on
> that bus.

Hmm, I wonder where my update patches went... oh, they're still sitting
in my excessive backlog of patches in my tree as part of my "sgtl5000
hacks" patch...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
