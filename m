From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 21 Oct 2012 19:59:05 +0200
Subject: [PATCH 2/2] ARM: kirkwood: use gpio-fan DT binding on lsxl
In-Reply-To: <201210211559.38628.michael@walle.cc>
References: <1350776094-16778-1-git-send-email-michael@walle.cc>
 <1350776094-16778-2-git-send-email-michael@walle.cc>
 <20121021065552.GH21046@lunn.ch>
 <201210211559.38628.michael@walle.cc>
Message-ID: <20121021175905.GK21046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi Michael
> > 
> > You might also be able to remove platform_device.h.
> 
> Mh, pm_power_off, although defined in linux/pm.h, is somehow pulled with this 
> include. So either we leave it that way (looking at other boards only a few 
> has included pm.h) or i'll post a third patch which replaces that include.

O.K, leave it as it is.

I hope to look at a DT solution for pm_power_off sometime soon.

  Andrew
