From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 8 Feb 2013 18:58:31 +0000 (UTC)
Subject: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
In-Reply-To: <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com>
 <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com>
 <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1302081855370.28008@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Keerthy,

On Fri, 8 Feb 2013, Paul Walmsley wrote:

> On Fri, 8 Feb 2013, J, KEERTHY wrote:
> 
> > Thanks for updating. Yes renaming the 'omap_clocks_register_links()
> > Is fine. I had blindly followed the hwmod function naming convention.
> > The new name makes sense.
> 
> OK great.  BTW don't forget to cc the linux-arm-kernel mailing list for 
> all patches, otherwise we won't be able to merge the patches.  Taking care 
> of it now in this case.

Just noticed during final testing of this patch that it causes some problems
with power management on OMAP4460: (see the suspend/resume messages)

http://www.pwsan.com/omap/testlogs/jk_clock_flags_cleanup_3.9/20130207183613/pm/4460pandaes/4460pandaes_log.txt

Could you please take a look at this and see what happened?  I suspect that
I screwed something up as I was rebasing the patch.  Unfortunately I don't
have the time to debug it further.


- Paul
