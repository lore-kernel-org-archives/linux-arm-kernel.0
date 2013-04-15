From: olof@lixom.net (Olof Johansson)
Date: Sun, 14 Apr 2013 20:20:55 -0700
Subject: [PATCHv3 1/3] ARM: socfpga: Enable soft reset
In-Reply-To: <20130414180729.GA11770@amd.pavel.ucw.cz>
References: <1365695726-26849-1-git-send-email-dinguyen@altera.com>
 <20130414180729.GA11770@amd.pavel.ucw.cz>
Message-ID: <20130415032055.GA10949@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 14, 2013 at 08:07:29PM +0200, Pavel Machek wrote:
> On Thu 2013-04-11 10:55:24, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Enable a cold or warm reset to the HW from userspace.
> > 
> > Also fix a few sparse errors:
> > 
> > warning: symbol 'sys_manager_base_addr' was not declared. Should it be static?
> > warning: symbol 'rst_manager_base_addr' was not declared. Should it be static?
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>

Applied 1-3 to next/soc in arm-soc.

Thanks!

-Olof
