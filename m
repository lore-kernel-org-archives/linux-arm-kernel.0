From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 Sep 2009 20:37:20 +0100
Subject: [PATCH 04/10] S3C64XX I2S: I2S controller-2 clock declare
In-Reply-To: <1253008956-10537-1-git-send-email-jassi.brar@samsung.com>
References: <1253008956-10537-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090916193720.GD6257@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:36PM +0900, Jassi wrote:
> Defined main clock for I2S controller-2 for S3C6410.

> Signed-Off-by: Jassi <jassi.brar@samsung.com>

You're also going to need to ensure that the audio-bus clock is handled
befoer the IISv4 driver is going to probe.
