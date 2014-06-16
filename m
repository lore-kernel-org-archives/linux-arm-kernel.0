From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Jun 2014 07:13:32 -0700
Subject: [PATCH v2 4/4] ARM: DTS: dra7/dra7xx-clocks: ATL related changes
In-Reply-To: <539EF8C6.1080207@ti.com>
References: <1399458048-28213-1-git-send-email-peter.ujfalusi@ti.com>
 <1399458048-28213-5-git-send-email-peter.ujfalusi@ti.com>
 <539EF8C6.1080207@ti.com>
Message-ID: <20140616141331.GK17845@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140616 07:03]:
> On 05/07/2014 01:20 PM, Peter Ujfalusi wrote:
> >Modify the clock nodes for the ATL clocks to use the ATL clock driver to
> >handle them.
> >
> >Add the ATL device node at the same time for DRA7.
> >
> >Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> This patch missed the merge window due to long dependency chain, however
> Tony promised to pull this with rc-fixes. So, for that purpose:
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks applying into omap-for-v3.16/fixes.

Regards,

Tony
