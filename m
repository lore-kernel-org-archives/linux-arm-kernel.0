From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 8 Jan 2013 13:07:04 +0000
Subject: [PATCH 2/4] gpiolib: add gpiod_get and gpiod_put functions
In-Reply-To: <1357629535-26033-3-git-send-email-acourbot@nvidia.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <1357629535-26033-3-git-send-email-acourbot@nvidia.com>
Message-ID: <201301081307.04229.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 January 2013, Alexandre Courbot wrote:
> 
> Adds new GPIO allocation functions that work with the opaque descriptor
> interface.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

I think you need to reorder the patches slightly, since the gpiod_get
function introduced here is already being used in the first patch, which
breaks bisection.

	Arnd
