From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Nov 2012 09:42:26 +0900
Subject: [PATCH 3/7] sh: pfc: Allow device tree registration
In-Reply-To: <1528017.UPeIBOTTC7@avalon>
References: <1353889014-17142-1-git-send-email-horms@verge.net.au>
 <1353889014-17142-4-git-send-email-horms@verge.net.au>
 <1528017.UPeIBOTTC7@avalon>
Message-ID: <20121127004225.GE9724@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 01:07:28AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Monday 26 November 2012 09:16:50 Simon Horman wrote:
> > This is a crude mechanism to allow the pfc driver to
> > be registered through device tree. The mofication of this
> > is to provide a way for pfc gpios to be looked up by
> > device tree for devices which use pfc gpios.
> > 
> > More specifically, the motivation is to allow the registration
> > of the card-detect gpio for the Micro-SD SDHI slot of the KZM9G board.
> 
> I've just posted v2 of my PCF patches ("SH pin control and GPIO rework with OF 
> support") that include OF support for GPIOs. This patch as well as patch 4/7 
> and the gpio node in patch 7/7 and shouldn't be required anymore.

Thanks.
