From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Jul 2011 01:00:05 -0600 (MDT)
Subject: [PATCH v2 10/18] OMAP4: clock data: Remove UNIPRO clock nodes
In-Reply-To: <1309552901-8944-11-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-11-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107060059330.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> UNIPRO was removed from OMAP4 devices from ES2.0 onwards.
> Since this IP was anyway non-functional and not supported,
> it is best to remove it completely.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [b-cousson at ti.com: Update the changelog]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>

The PRCM data changes in this patch have been separated from the clock
data changes.  The PRCM data changes have been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
The clock data changes have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Thanks,

- Paul
