From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Tue, 01 Feb 2011 13:07:35 +0100
Subject: [PATCH 3/9] Add a mfd IPUv3 driver
In-Reply-To: <20110201115125.GE31216@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 1 Feb 2011 11:51:25 +0000")
References: <1292842127-21406-1-git-send-email-s.hauer@pengutronix.de>
	<1292842127-21406-4-git-send-email-s.hauer@pengutronix.de>
	<20110201105127.GA10128@sortiz-mobl>
	<20110201105909.GS9041@pengutronix.de>
	<20110201114453.GC10128@sortiz-mobl>
	<20110201115125.GE31216@n2100.arm.linux.org.uk>
Message-ID: <87wrlkyn3s.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, Feb 01, 2011 at 12:44:54PM +0100, Samuel Ortiz wrote:
>> Ok, so would moving it do drivers/video/ make sense ?
>
> Isn't that for framebuffer drivers?

For now, the ipu driver is used for framebuffer on imx5.

Arnaud
