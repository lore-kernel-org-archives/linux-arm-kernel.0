From: juha-matti.tilli@iki.fi (Juha-Matti Tilli)
Date: Thu, 21 Aug 2014 21:03:29 +0300
Subject: [PATCH v5 0/4] Tegra124 soctherm driver
In-Reply-To: <20140821160127.GA17621@developer>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
 <20140821122011.GA99564@sandfort.unics.fi>
 <20140821160127.GA17621@developer>
Message-ID: <20140821180329.GA5447@sandfort.unics.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 21, 2014 at 12:01:29PM -0400, Eduardo Valentin wrote:
> I suppose the 4 C to 5 C difference is not seen anymore in this version,
> right?

Yes, I verified that this newest version writes identical calibration
values to the CONFIG2 registers than the NVIDIA's internal downstream
driver and therefore the temperature difference is not seen anymore.
All the bugs I reported have been fixed in this version.
