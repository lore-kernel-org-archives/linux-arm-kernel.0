From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 19 Dec 2013 20:03:29 +0100
Subject: [PATCH 3/4] SATA: MV: Add support for the optional PHYs
In-Reply-To: <52B140F2.8070900@ti.com>
References: <1387311713-1926-1-git-send-email-andrew@lunn.ch>
 <1387311713-1926-3-git-send-email-andrew@lunn.ch>
 <52B140F2.8070900@ti.com>
Message-ID: <20131219190329.GH4143@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:00:10PM +0530, Kishon Vijay Abraham I wrote:
> Hi Tejun,
> 
> On Wednesday 18 December 2013 01:51 AM, Andrew Lunn wrote:
> > Some Marvell SoCs have a SATA PHY which can be powered off, in order
> > to save power. Make use of the generic phy framework to control these
> > phys.
> 
> I can queue this patch along with the other patches in this series if you don't
> expect any merge issues.

Hi Kishon

I expect merge issues with the DT and the DT binding documentation. It
would be best if Jason took those parts.

      Andrew
