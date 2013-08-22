From: mgreer@animalcreek.com (Mark A. Greer)
Date: Thu, 22 Aug 2013 14:24:02 -0700
Subject: [PATCH v2 0/2] ARM: dts: Add SHAM and AES DT information
In-Reply-To: <5215CCFE.6040500@baylibre.com>
References: <1374078222-12883-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.02.1308210012420.6426@utopia.booyaka.com>
 <5214C11F.8090808@baylibre.com> <5214C372.3080402@baylibre.com>
 <52158A7E.30305@ti.com> <5215CCFE.6040500@baylibre.com>
Message-ID: <20130822212402.GA30504@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 22, 2013 at 10:34:06AM +0200, Benoit Cousson wrote:
> Hi Lokesh,
> 
> On 22/08/2013 05:50, Lokesh Vutla wrote:
> >Hi Benoit,
> >On Wednesday 21 August 2013 07:11 PM, Benoit Cousson wrote:
> >>Hi Mark,
> >>
> >>In fact I cannot even apply these patches since they are referring the the edma controller node that does not seem to be there in 3.11-rc6.
> >>
> >>Is this EDMA series supposed to be merged for 3.12? If this is the case, where can I find a reference GIT for it?
> >The following EDMA support dt patch series from Joel is needed :
> >http://www.mail-archive.com/linux-omap at vger.kernel.org/msg92176.html
> >http://www.mail-archive.com/linux-omap at vger.kernel.org/msg92177.html
> 
> Thanks, it works a little bit better with these patches :-)

Yeah, sorry.

Given Mark Rutland's comments in another email, let me respin and send v3.
I'll put a comment about the dependencies this time.

Mark
--
