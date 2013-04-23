From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:11:35 +0200
Subject: [PATCH] usb: phy: phy core cannot yet be a module
In-Reply-To: <20130423160759.GF15177@arwen.pp.htv.fi>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-2-git-send-email-arnd@arndb.de>
 <20130423160759.GF15177@arwen.pp.htv.fi>
Message-ID: <201304231811.35692.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Felipe Balbi wrote:
> looks like this is the only way, indeed. Do you need on the merge window
> on can this wait until -rc1 ? I just sent a pull request to Greg with
> urgent fixes for the merge window.
> 
> Greg, if you want to take this one as a patch, go for it:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

It's not relevant for real-life scenarios, it's fine as long as this
makes it into 3.10.

	Arnd
