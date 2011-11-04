From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 12:58:38 -0700
Subject: [PATCH 1/4] mmc: Add additional binding for mmc host controller
In-Reply-To: <1320407441-29697-2-git-send-email-rnayak@ti.com>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
	<1320407441-29697-2-git-send-email-rnayak@ti.com>
Message-ID: <20111104195838.GB3045@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 05:20:38PM +0530, Rajendra Nayak wrote:
> Add mmc host controller capability binding to support
> 'MMC_CAP_POWER_OFF_CARD' powering off of the card after boot.

This adds a new undocumented property (also, see comments on Thomas Abraham's
patch for more comments on that approach and why it's the wrong thing to do).

This needs to be handled differently.


-Olof
