From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Feb 2011 09:46:26 -0700 (MST)
Subject: [PATCH] OMAP4: clockdomain: Remove pr_errs' stating unsupported
	wkdep
In-Reply-To: <1297685165-25489-1-git-send-email-rnayak@ti.com>
References: <1297685165-25489-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1102140938070.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> Now that wkup and sleep dependencies are supported (in the
> form of static deps) for OMAP4, remove all instances of
> pr_errs' stating dependencies are still unsupported
> on OMAP4.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, queued for 2.6.39 in the 'clkdm_statdep_omap4_2.6.39' branch of 
git://git.pwsan.com/linux-2.6.

This patch is part of the 'integration-2.6.39' branch of 
git://git.pwsan.com/linux-integration as of tag 
'integration-2.6.39-20110214-003'.


- Paul
