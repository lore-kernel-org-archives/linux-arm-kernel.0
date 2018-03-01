From: tony@atomide.com (Tony Lindgren)
Date: Wed, 28 Feb 2018 19:49:47 -0800
Subject: [PATCH 11/12] PM / AVS: SmartReflex: Prepare to use device tree
 based probing
In-Reply-To: <7hr2p41ok8.fsf@baylibre.com>
References: <20180223210100.86732-1-tony@atomide.com>
 <20180223210100.86732-12-tony@atomide.com>
 <7hr2p41ok8.fsf@baylibre.com>
Message-ID: <20180301034947.GE62820@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@baylibre.com> [180301 03:08]:
> Tony Lindgren <tony@atomide.com> writes:
> > We are currently probing smartreflex with omap_device while we are
> > already probing smartreflex related interconnect target module with
> > ti-sysc driver and dts data.
...

> Acked-by: Kevin Hilman <khilman@baylibre.com>
> 
> I don't have anything else queued for this driver, so feel free to take
> it along with the rest of the series.

Thanks for looking, will do.

Tony
