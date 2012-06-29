From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jun 2012 15:09:45 +0200
Subject: [PATCH 0/2] MC13xxx: fix access on i.mx31
In-Reply-To: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1338282389-26177-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120629130945.GK4846@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,


On Tue, May 29, 2012 at 11:06:27AM +0200, Philippe R?tornaz wrote:
> Hello
> 
> This patchset fixes the mc13xxx regression introduced by:
> "mfd: Use regmap for the mc13xxx-core register access".
> 
> The first patch correct the write_flag_mask to use the correct value
> and remove the invalid bits_per_word in the probe.
> 
> The second patch workaround an silicon errata on some imx SoC.
Both patches applied to my for-linus branch. They'll be part of the MFD fixes
pull request for 3.5.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
