From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 15 Apr 2013 10:06:18 -0500
Subject: [PATCHv3 1/3] ARM: socfpga: Enable soft reset
In-Reply-To: <20130415032055.GA10949@quad.lixom.net>
References: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
 <20130414180729.GA11770@amd.pavel.ucw.cz>
 <20130415032055.GA10949@quad.lixom.net>
Message-ID: <1366038378.9074.0.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Sun, 2013-04-14 at 20:20 -0700, Olof Johansson wrote:
> On Sun, Apr 14, 2013 at 08:07:29PM +0200, Pavel Machek wrote:
> > On Thu 2013-04-11 10:55:24, dinguyen at altera.com wrote:
> > > From: Dinh Nguyen <dinguyen@altera.com>
> > > 
> > > Enable a cold or warm reset to the HW from userspace.
> > > 
> > > Also fix a few sparse errors:
> > > 
> > > warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> > > warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> > > 
> > > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Reviewed-by: Pavel Machek <pavel@denx.de>
> 
> Applied 1-3 to next/soc in arm-soc.

Thanks alot!

Dinh
> 
> Thanks!
> 
> -Olof
> 
