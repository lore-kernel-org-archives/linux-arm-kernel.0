From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Mon, 25 Sep 2017 07:25:00 +0000
Subject: [PATCH v2] ARM: dts: iwg22d: Enable SDHI0 controller
In-Reply-To: <20170925071800.GF1019@verge.net.au>
References: <TY1PR06MB0702E99A48352C055705E3A9B7670@TY1PR06MB0702.apcprd06.prod.outlook.com>
 <1506085262-13639-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <TY1PR06MB08955E235768A72D33FE2AD3C0670@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20170925071800.GF1019@verge.net.au>
Message-ID: <TY1PR06MB07025B6A19C90C354EA23775B77A0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 25 September 2017 08:18
> 
> On Fri, Sep 22, 2017 at 01:33:39PM +0000, Fabrizio Castro wrote:
> > Hello Simon,
> >
> > just to clarify the changes between v1 and v2, we can't use SDR50 and
> SDR104 (due to an HW issue) therefore the pinctrl for UHS has been
> removed and we dropped property "sd-uhs-sdr104". High Speed has been
> tested, therefore if you are happy with the patch I guess you can update the
> following page accordingly:
> > http://elinux.org/index.php?title=Renesas-MMC-Enabled-
> Speeds&type=revi
> > sion&diff=451426&oldid=451421
> >
> > Although (due to a bug) sdhi0 may not hold a reference to "vccq_sdhi0",
> the gpio regulator will initialize "SDHI0 VccQ" at 3.3V.
> > I have sent another patch (mmc: tmio: check mmc_regulator_get_supply
> return value) to start a discussion about a possible fix for the bug.
> >
> > Let me know if you need more information.
> 
> Thanks again for following up on this.
> 
> I have applied the patch with Geert's tag.

Thanks

> 
> I have also updated the Wiki at the URL above, feel free to make any further
> updates there as appropriate.

Thanks, looks okay to me.

Kind regards, Chris
