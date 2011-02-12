From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 12 Feb 2011 16:17:48 -0700 (MST)
Subject: [PATCH 1/7] omap: clock: Check for enable/disable ops support
In-Reply-To: <1297159838-30282-2-git-send-email-rnayak@ti.com>
References: <1297159838-30282-1-git-send-email-rnayak@ti.com>
	<1297159838-30282-2-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1102121615130.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Feb 2011, Rajendra Nayak wrote:

> Check if enable/disable operations are supported for a given
> clock node before attempting to call them.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued in branch 'clk_a_2.6.39' of git://git.pwsan.com/linux-2.6.  

This patch is integrated as part of the tag 
'tmp-integration-2.6.39-20110212-003' and the branch 'integration-2.6.39' 
of git://git.pwsan.com/linux-integration.


- Paul
