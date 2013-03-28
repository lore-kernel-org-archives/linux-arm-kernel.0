From: mfuzzey@parkeon.com (Martin Fuzzey)
Date: Thu, 28 Mar 2013 09:41:35 +0100
Subject: [PATCH v2 10/11] ARM i.MX53: Add LDB device to device tree
In-Reply-To: <20130328073212.GM5429@S2101-09.ap.freescale.net>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-11-git-send-email-p.zabel@pengutronix.de>
 <51533DDC.2030401@parkeon.com>
 <20130328073212.GM5429@S2101-09.ap.freescale.net>
Message-ID: <5154023F.600@parkeon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/13 08:32, Shawn Guo wrote:
> On Wed, Mar 27, 2013 at 07:43:40PM +0100, Martin Fuzzey wrote:
>>
>> Maybe pinctrl entries should also be added?
> Generally, the pinctrl entries should be added in <board>.dts.

Yes sorry I meant the pinctrl groups under the iomuxc node.

Regards,
Martin
