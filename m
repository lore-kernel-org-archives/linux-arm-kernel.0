From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 9 Aug 2013 15:22:11 +0200
Subject: [PATCH 1/3] i2c-mv64xxx: Add I2C Transaction Generator support
In-Reply-To: <5203B97A.8060605@free-electrons.com>
References: <1373898278-4805-1-git-send-email-gregory.clement@free-electrons.com>
 <1373898278-4805-2-git-send-email-gregory.clement@free-electrons.com>
 <20130716080503.GA3125@lukather>
 <5200E684.5080003@free-electrons.com>
 <20130807143546.GD2978@katana>
 <20130807155700.GE19280@titan.lakedaemon.net>
 <5203B97A.8060605@free-electrons.com>
Message-ID: <20130809132211.GA3517@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Does it mean that once I will have added the handle of this string,
> you will be able to take the series for the 3.12 kernel?

Most looks good. The only thing I noticed from a glimpse is that maybe
you could use be32_to_cpu or something instead of shifting 8 bit chunks
out of the data_hi/lo?
