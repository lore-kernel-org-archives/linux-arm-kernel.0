From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 16:16:07 +0100
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107144450.GF20844@opensource.wolfsonmicro.com>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
 <20121107104121.GG20063@game.jcrosoft.org>
 <20121107140535.GA28954@opensource.wolfsonmicro.com>
 <20121107143046.GA4576@game.jcrosoft.org>
 <20121107144450.GF20844@opensource.wolfsonmicro.com>
Message-ID: <20121107151607.GC4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:44 Wed 07 Nov     , Mark Brown wrote:
> On Wed, Nov 07, 2012 at 03:30:46PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > the one via ASoC for the driver with the pinctrl for now but MUST add it later
> 
> > the arch/arm related via AT91 tree where the pinctrl is mandatory in the dtsi
> 
> > I'm no going to spend hours to do the pinctrl to test Bo patch that he is
> > supposed to have deon to test this code
> 
> > As basically today on DT none of the board will work if BO does no provide the
> > pinctrl so for me he MUST put in the dtsi
> 
> > is it ok with you?
> 
> Or add the pinmux bindings for other IPs over in the pinmux branch and
> the pinmux binding for SSC here (which will help with bisection as the
> DT bindings for the audio will then always exist in conjunction with the
> .dtsi changes for them).  Either way is fine with me; I'll leave things
> as they are until I see some new patches.
for where it's merge honestly I do not care much but the pinctrl must be
handled correctly

Best Regards,
J.
