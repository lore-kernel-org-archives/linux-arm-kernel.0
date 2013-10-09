From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Oct 2013 14:55:43 +0000 (UTC)
Subject: [PATCH v2 3/5] ARM: OMAP2+: hwmod: Extract no-idle and no-reset
 info from DT
In-Reply-To: <1381313521-10422-4-git-send-email-rnayak@ti.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
 <1381313521-10422-4-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1310091455300.30199@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Rajendra Nayak wrote:

> Now that we have DT bindings to specify which devices should not
> be reset and idled during init, make hwmod extract the information
> (and store them in internal flags) from Device tree.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued.

- Paul
