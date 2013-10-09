From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Oct 2013 14:55:21 +0000 (UTC)
Subject: [PATCH v2 1/5] ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET
 usage
In-Reply-To: <1381313521-10422-2-git-send-email-rnayak@ti.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
 <1381313521-10422-2-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.02.1310091455020.30199@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Oct 2013, Rajendra Nayak wrote:

> For modules/IPs/hwmods which do not have
> -1- sys->class->reset()
> and
> -2- hardreset lines
> and
> -3- No way to do an ocp reset (no sysc control)
> the flag 'HWMOD_INIT_NO_RESET' is not much useful.
> 
> Cleanup all such instances across various hwmod data files.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued.


- Paul
