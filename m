From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 18:20:35 -0500
Subject: [PATCH v4 00/13] Core support for Marvell Armada 375 and 38x
In-Reply-To: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1392647011-30117-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140217232035.GH7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 03:23:18PM +0100, Thomas Petazzoni wrote:
> Jason, Andrew, Sebastian, Gregory,
> 
> Here comes the v4 of the Armada 375/38x core support.

Whole series applied as follows:

  Patches 1-6, 9, 13   -> mvebu/soc-3xx

  Patches 7, 8, 10, 11 -> mvebu/dt-3xx

  Patch 12             -> mvebu/defconfig

I probably don't need to put the DT changes into a separate branch, but
I'd hate to see a bunch of new board support dropped if there is
something wrong with the new SoC support.  So caution wins the day.

thx,

Jason.
