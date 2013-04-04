From: jon-hunter@ti.com (Jon Hunter)
Date: Thu, 4 Apr 2013 16:01:17 -0500
Subject: [PATCH 5/5] ARM: dts: OMAP2+: Identify GPIO banks that are always
 powered
In-Reply-To: <20130404203519.GR10155@atomide.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-6-git-send-email-jon-hunter@ti.com>
 <20130404203519.GR10155@atomide.com>
Message-ID: <515DEA1D.9070001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/04/2013 03:35 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [130404 13:21]:
>> Add the "ti,gpio-always-on" property to the appropriate GPIO banks to
>> indicate which banks are always powered and will never lose logic state.
> 
> This patch should be queued by Benoit as this will likely cause
> pointless merge conflicts with the other .dts files.

Yes agreed. I mentioned that in the cover-letter.

Cheers
Jon
