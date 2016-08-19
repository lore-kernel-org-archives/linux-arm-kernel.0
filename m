From: kbeldan@baylibre.com (Karl Beldan)
Date: Fri, 19 Aug 2016 17:42:38 +0000
Subject: [PATCH v3 0/4] Add DT support for NAND to LCDK via ti-aemif
In-Reply-To: <234aeb42-4373-a996-c782-1dac95838d07@ti.com>
References: <20160816223338.20776-1-kbeldan@baylibre.com>
 <m2wpjeqa0o.fsf@baylibre.com> <m2vayxn5gw.fsf@baylibre.com>
 <20160819134602.GA3056@gobelin>
 <234aeb42-4373-a996-c782-1dac95838d07@ti.com>
Message-ID: <20160819174238.GA7526@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2016 at 07:40:35PM +0530, Sekhar Nori wrote:
> On Friday 19 August 2016 07:16 PM, Karl Beldan wrote:
> 
> > Sure, I'll add it to the series when resending.
> 
> I just pushed an updated master branch on my tree with all the patches
> accepted so far. Can you please rebase against that branch while sending?
> 

I rebased and sent
  [1] [PATCH] ARM: davinci_all_defconfig: Enable some UBI modules
  [2] [PATCH v2] ARM: davinci: da8xx-dt:
                 Add ti-aemif lookup for clock matching

Unfortunately while automating I messed up and sent both twice and [2] as
a reply to [1] while I intended to send them separately and preferably
[1] after [2].

You've already applied patches 2/4 and 3/4 of the original series
while 3/4 depends on [2] and 4/4 is on hold because of the ECC issue.

Please tell me if you want to deal with these patches or prefer a resend.

Regards, 
Karl
