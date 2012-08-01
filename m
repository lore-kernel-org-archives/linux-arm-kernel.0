From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 1 Aug 2012 15:49:53 +0800
Subject: [RFC PATCH 1/1] ASoC: soc-dapm: warn if no avaiable path found
 for widget kcontrol
In-Reply-To: <20120729202219.GA4384@opensource.wolfsonmicro.com>
References: <1343387941-25266-1-git-send-email-b29396@freescale.com>
 <20120729202219.GA4384@opensource.wolfsonmicro.com>
Message-ID: <20120801074952.GC30492@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 04:22:19AM +0800, Mark Brown wrote:
> On Fri, Jul 27, 2012 at 07:19:01PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > This could help people know what's wrong going on if the required
> > path is not registered.
> 
> This isn't a good idea, it's fairly common for widgets to have a "None"
> option which isn't expected to have an input.
> 

What i changed is mux widgets, i'm wondering is it possible or correct
the mux widget has no input path?
If i understand correct, we may need set correct input path
for mux widget, or why we still need a mux?

Or can you help give an example that no input needed for mux widget?

Regards
Dong Aisheng
