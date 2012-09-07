From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 7 Sep 2012 19:14:11 +0200
Subject: [PATCH v3] pwm i.MX: add devicetree support
In-Reply-To: <20120907131037.GD29340@avionic-0098.mockup.avionic-design.de>
References: <1346935695-25179-1-git-send-email-s.hauer@pengutronix.de>
 <20120907131037.GD29340@avionic-0098.mockup.avionic-design.de>
Message-ID: <20120907171411.GT26594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 03:10:37PM +0200, Thierry Reding wrote:
> On Thu, Sep 06, 2012 at 02:48:06PM +0200, Sascha Hauer wrote:
> > The following is the third version of the i.MX pwm series. I integrated
> > the remaining comments from Shawn and Beno?t and added their tags.
> > 
> > So Thierry, please pull the attached patches. The pull request only
> > contains the pwm framework specific patches, the remaining two I'd
> > like to push via the arm-soc tree in case the i.MX5 also gets devicetree
> > clock lookups.
> 
> Hi Sascha,
> 
> Sorry for taking so long to get back to you. Apart from my comments to
> patch 1, I really like how this series cleans up the i.MX driver. It's
> already a bit late in the 3.6 release cycle for these kinds of changes
> and none of them fix any regressions, so I'd like to queue them for
> 3.7 after my comments have been addressed.

Sure, no problem. The patches were never intended to go in for 3.6. I
will address your comments and resend on monday.

Thanks
 Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
