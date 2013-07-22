From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 22 Jul 2013 15:47:35 +0800
Subject: [PATCH v8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <51E95F10.5070006@wwwdotorg.org>
References: <20130716041056.GA30067@S2101-09.ap.freescale.net>
 <51E56AA7.7020103@wwwdotorg.org>
 <20130717030246.GA4541@S2101-09.ap.freescale.net>
 <51E6CCE4.20705@wwwdotorg.org>
 <20130717213836.GA13324@amd.pavel.ucw.cz>
 <51E719A6.6070105@wwwdotorg.org>
 <20130718112555.GB1021@amd.pavel.ucw.cz>
 <CAOesGMgi0j_mPyeBLVHb_QW+DwtAPoFY697eQO3-yp9tnP1vmA@mail.gmail.com>
 <20130719032328.GB20889@S2101-09.ap.freescale.net>
 <51E95F10.5070006@wwwdotorg.org>
Message-ID: <20130722074733.GA20271@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 09:45:20AM -0600, Stephen Warren wrote:
> That sounds like it /could/ well be an issue. Do you have all that
> actually hooked up through device tree so you can demonstrate the amount
> of deferred probing that /actually/ happens though?
> 
> In order to push the probe order in the right direction, I would
> personally prefer to see some kind of explicit hinting or outright
> representation of probe order in the DT.

I do not have a kernel supporting all those devices yet.

Shawn
