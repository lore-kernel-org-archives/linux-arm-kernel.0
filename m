From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 30 Mar 2013 22:49:39 +0000 (UTC)
Subject: [GIT PULL] ARM: OMAP2+: standardize integration for AES & SHA/MD5
 IP blocks for 3.9
In-Reply-To: <20130304185019.GP11806@atomide.com>
References: <alpine.DEB.2.00.1302081752190.28008@utopia.booyaka.com>
 <20130304185019.GP11806@atomide.com>
Message-ID: <alpine.DEB.2.00.1303302247510.6436@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Mon, 4 Mar 2013, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [130208 09:57]:
>
> > For OMAP2+ SoCs, convert the SHA/MD5 and AES accelerator integration
> > code and data to use hwmod and omap_device.  This is a prerequisite for moving
> > the hwmod code out of arch/arm.
> > 
> > Basic test logs are available at:
> > 
> >     http://www.pwsan.com/omap/testlogs/sham_aes_integration_devel_3.9/20130208093215/
> 
> Sorry looks like I totally missed this one somehow as discussed last
> week. Anyways, let's get it queued early at -rc2 or so, let me know
> if you want to update the branch or if I should just use this pull
> request.

Well, I missed -rc2, but here it is:

http://marc.info/?l=linux-arm-kernel&m=136468366425369&w=2

It's got a dependency on omap-cleanup-a-for-3.10 (the clock flags 
removal).


- Paul
