From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 17 Feb 2011 18:47:25 +0100
Subject: [PATCH 2/8] OMAP4: hwmod data: Add McSPI
In-Reply-To: <20110217170514.GS20795@atomide.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
	<1297938289-8678-3-git-send-email-b-cousson@ti.com>
	<20110217170514.GS20795@atomide.com>
Message-ID: <4D5D5F2D.9020100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/17/2011 6:05 PM, Tony Lindgren wrote:
> Hi,
> 
> Noticed one cosmetic thing below.
> 
> * Benoit Cousson<b-cousson@ti.com>  [110217 02:23]:
>> Update omap4 hwmod file with McSPI info.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Charulatha V<charu@ti.com>
>> Signed-off-by: Govindraj.R<govindraj.raja@ti.com>
>> Acked-by: Grant Likely<grant.likely@secretlab.ca>
>> Reviewed-by: Kevin Hilman<khilman@ti.com>
>> ---
>    ^^^ That should not be here, it shows up in your commit.
> 
>> [b-cousson at ti.com: Remove dev_attr to prevent dependency
>> with device code. It will have to be re-added along with
>> the original series]
> 
> As the above should be part of the commit too. Care to
> refresh your branch for that?

Done. I added the USBOTG for Felipe as well.

Thanks,
Benoit

---

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:
  Linus Torvalds (1):
        Linux 2.6.38-rc5

are available in the git repository at:

  git://gitorious.org/omap-pm/linux.git for_2.6.39/omap4_hwmod_data

Benoit Cousson (9):
      OMAP4: hwmod data: Add hwspinlock
      OMAP4: hwmod data: Add McSPI
      OMAP4: hwmod data: Add timer
      OMAP4: hwmod data: Add DSS, DISPC, DSI1&2, RFBI, HDMI and VENC
      OMAP4: hwmod data: Add mailbox
      OMAP4: hwmod data: Add DMIC
      OMAP4: hwmod data: Add McBSP
      OMAP4: hwmod data: Add AESS, McPDM, bandgap, counter_32k, MMC, KBD, ISS & IPU
      OMAP4: hwmod data: Add USBOTG

 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3119 +++++++++++++++++++++++++++-
 1 files changed, 3072 insertions(+), 47 deletions(-)
 
