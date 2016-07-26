From: michael.weiser@gmx.de (Michael Weiser)
Date: Tue, 26 Jul 2016 21:26:09 +0200
Subject: [PATCH 3/3] ARM: sunxi: enable big-endian
In-Reply-To: <20160725122522.GL7419@lukather>
References: <20160721182329.13478-1-michael.weiser@gmx.de>
 <20160721182329.13478-4-michael.weiser@gmx.de>
 <20160722090101.GB7687@lukather>
 <20160722135658.GA18977@weiser.dinsnail.net>
 <20160725122522.GL7419@lukather>
Message-ID: <20160726192609.GA27782@weiser.dinsnail.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Mon, Jul 25, 2016 at 02:25:22PM +0200, Maxime Ripard wrote:

> > via I2C. I have not deliberately/synthetically tested the DMA engine. It's
> > enabled in the my kernel config and seems happy but was not selected by
> > any other driver so seems to be unused currently.
> You can test the DMA using the audio components, either the codec, i2s
> or spdif.

I've enabled the codec and it's currently playing some King Khan to me.
