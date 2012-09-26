From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 26 Sep 2012 09:45:58 +0530
Subject: [PATCHv5 00/10] ARM: OMAP: PM usecounting changes
In-Reply-To: <1348582676.10702.302.camel@sokoban>
References: <1348565565-14744-1-git-send-email-t-kristo@ti.com>
 <506186E9.7070908@ti.com> <1348574001.10702.291.camel@sokoban>
 <5061A22B.1030603@ti.com> <1348582676.10702.302.camel@sokoban>
Message-ID: <5062817E.8090300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012 07:47 PM, Tero Kristo wrote:
> Actually I think I accidentally fixed this problem with the latest rev,
> due to the fact that I am using generic clkdm_clk_enable / disable calls
> from iclk now.
>
> I also just tested this (while fixing the complaint from Russell), and
> it looks like both USB and DSS pwrdms are remaining nicely idle on
> OMAP3.

oh, we are good in that case then. Thanks for the update.
