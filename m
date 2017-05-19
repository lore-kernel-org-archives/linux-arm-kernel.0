From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 May 2017 11:41:22 -0700
Subject: [PATCH] ARM: dts: omap3: Remove 'enable-active-low' property
In-Reply-To: <1495039459-23223-1-git-send-email-fabio.estevam@nxp.com>
References: <1495039459-23223-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20170519184122.GH10472@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Fabio Estevam <fabio.estevam@nxp.com> [170517 09:47]:
> From: Fabio Estevam <festevam@gmail.com>
> 
> Property 'enable-active-low' does not exist. Only 'enable-active-high' is
> valid, and when this property is absent the gpio regulator will act as
> active low by default.
> 
> So remove the unexisting 'enable-active-low' property. 

Applying into omap-for-v4.13/dt thanks.

Tony
