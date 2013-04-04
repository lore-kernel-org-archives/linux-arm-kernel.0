From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Apr 2013 14:08:03 -0700
Subject: [PATCH 5/5] ARM: dts: OMAP2+: Identify GPIO banks that are
 always powered
In-Reply-To: <515DEA1D.9070001@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-6-git-send-email-jon-hunter@ti.com>
 <20130404203519.GR10155@atomide.com> <515DEA1D.9070001@ti.com>
Message-ID: <20130404210801.GT10155@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [130404 14:05]:
> 
> On 04/04/2013 03:35 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [130404 13:21]:
> >> Add the "ti,gpio-always-on" property to the appropriate GPIO banks to
> >> indicate which banks are always powered and will never lose logic state.
> > 
> > This patch should be queued by Benoit as this will likely cause
> > pointless merge conflicts with the other .dts files.
> 
> Yes agreed. I mentioned that in the cover-letter.

OK thanks.

Tony
