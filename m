From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 6 Jul 2011 00:59:12 -0600 (MDT)
Subject: [PATCH v2 09/18] OMAP4: clock data: Remove McASP2, McASP3 and
	MMC6 clocks
In-Reply-To: <1309552901-8944-10-git-send-email-b-cousson@ti.com>
References: <1309552901-8944-1-git-send-email-b-cousson@ti.com>
	<1309552901-8944-10-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1107060057100.4217@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011, Benoit Cousson wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> McASP2, 3 and MMC6 modules are not present in the OMAP4 family.
> Remove the fclk and the clksel related to these nodes.
> Rename the references that were potentially re-used in order nodes.
> 
> Remove related macros in prcm header files.
> 
> Update TI copyright date.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> [b-cousson at ti.com: Update the patch according to autogen output]
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

The PRCM data changes in this patch have been separated from the clock
data changes.  The PRCM data changes have been queued for 3.1 at 
git://git.pwsan.com/linux-2.6 in the 'prcm_cleanup_a_3.1' branch.
The clock data changes have been queued for 3.1 at
git://git.pwsan.com/linux-2.6 in the 'clock_cleanup_a_3.1' branch.

Thanks,

- Paul
