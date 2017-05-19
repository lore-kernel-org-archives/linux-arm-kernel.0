From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 19 May 2017 19:05:52 +0200
Subject: [PATCH 5/6] gpio: mvebu: Add support for the Armada 7K/8K SoCs
In-Reply-To: <20170519162736.GU22219@n2100.armlinux.org.uk>
References: <cover.e10718b9c0f9fdd07327ae14e213be8da5b1f7ef.1495210061.git-series.gregory.clement@free-electrons.com>
 <54efbdfb0a9800b2c72c6fa1d945c87182b242b4.1495210061.git-series.gregory.clement@free-electrons.com>
 <20170519162410.GT22219@n2100.armlinux.org.uk>
 <20170519162736.GU22219@n2100.armlinux.org.uk>
Message-ID: <20170519190552.744183b0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 19 May 2017 17:27:36 +0100, Russell King - ARM Linux wrote:

> Hmm, in fact, mvebu->offset always appears to be zero in this driver,
> so I think the changes that add this member are entirely rendundant to
> the function of this patch.

>From PATCH 6/6:

+					offset = <0x1040>;

+					offset = <0x100>;

+					offset = <0x140>;

So, no mvchip->offset is not always 0.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
