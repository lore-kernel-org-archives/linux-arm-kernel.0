From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 10 Feb 2013 19:17:10 +0100
Subject: [RFC] i2c: Providing hooks for i2c multimaster bus arbitration.
In-Reply-To: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
References: <1359968595-21291-1-git-send-email-yuvaraj.cd@samsung.com>
Message-ID: <20130210181710.GB12760@nekote.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 02:33:15PM +0530, Yuvaraj Kumar C D wrote:
> This RFC patch is w.r.t multimaster bus arbitration which is already
> being discussing in the mainline.
> This patch provides hooks for the i2c multimaster bus arbitration
> and to have the arbitration parameters.

I still haven't understood why the arbitration specified in the I2C
standard is not enough for you. Or what you would need to make use of
it.

Thanks,

   Wolfram
