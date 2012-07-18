From: attila@kinali.ch (Attila Kinali)
Date: Wed, 18 Jul 2012 08:07:55 +0200
Subject: [PATCH 05/10] mmc: spi: Pull out the SSP clock configuration
 function
In-Reply-To: <201207172348.34919.marex@denx.de>
References: <1342440597-8395-1-git-send-email-marex@denx.de>
 <1342440597-8395-6-git-send-email-marex@denx.de>
 <20120717153901.5530a246a7a5fecfef03b373@kinali.ch>
 <201207172348.34919.marex@denx.de>
Message-ID: <20120718080755.cf7d4ac2e423278ce12843e6@kinali.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Good morning Marek,

On Tue, 17 Jul 2012 23:48:34 +0200
Marek Vasut <marex@denx.de> wrote:

> > There is a EXPORT_SYMBOL_GPL(mxs_ssp_set_clk_rate); missing here.
> 
> What for?

To be able to compile mxs-mmc as a module

			Attila Kinali

-- 
Why does it take years to find the answers to
the questions one should have asked long ago?
