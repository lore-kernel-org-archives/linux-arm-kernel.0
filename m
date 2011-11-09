From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 9 Nov 2011 10:01:44 +0000
Subject: [PATCHv4 00/13] VIC DT binding and MULTI_IRQ_HANDLER
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111109100144.GA4253@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 01:09:57AM +0000, Jamie Iles wrote:
> Since the last revision I've updated the handling loop as suggested by
> Linus and Russell, added a patch for picoxcell and added a final patch
> to remove the non MULTI_IRQ_HANDLER support for VIC.  The final patch
> assumes that all VIC users will be converted to MULTI_IRQ_HANDLER which
> I would hope would be the case but this could be dropped if not.
> 
> I've also included Marc's patch for reference as the mach patches are
> dependent on it.
> 
> Jamie Iles (12):
>   ARM: vic: device tree binding
>   ARM: vic: MULTI_IRQ_HANDLER handler
>   ARM: ep93xx: convert to MULTI_IRQ_HANDLER
>   ARM: netx: convert to MULTI_IRQ_HANDLER
>   ARM: nomadik: convert to MULTI_IRQ_HANDLER
>   ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
>   ARM: spear: convert to MULTI_IRQ_HANDLER
>   ARM: u300: convert to MULTI_IRQ_HANDLER
>   ARM: versatile: convert to MULTI_IRQ_HANDLER
>   ARM: samsung: convert to MULTI_IRQ_HANDLER
>   ARM: picoxcell: convert to MULTI_IRQ_HANDLER
>   ARM: VIC: remove non MULTI_IRQ_HANDLER support

Marc has kindly offered to take these with his GIC patches so I'd like 
to send him a pull request tomorrow.  Some Acked-by/Tested-by's for the 
other platforms would be much appreciated!

Thanks,

Jamie
