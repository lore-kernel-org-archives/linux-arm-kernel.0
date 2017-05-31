From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 31 May 2017 11:16:45 +0200
Subject: [PATCH 0/6] Extend mvebu gpio driver to support the controllers
 of the Marvell Armada 7K/8K
In-Reply-To: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
Message-ID: <20170531111645.6530911a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 19 May 2017 18:09:19 +0200, Gregory CLEMENT wrote:

> Not that currently I didn't manage to fully test the gpio, indeed I
> only have a 7040 DB board which lack of test point for this kind of
> test. So any tested-by would be welcome.

I have tested GPIOs on the master CP110 of the Armada 8K on a
MacchiatoBin board, and they worked for me, so you can add my:

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
