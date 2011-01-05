From: balbi@ti.com (Felipe Balbi)
Date: Wed, 5 Jan 2011 16:18:14 +0200
Subject: OMAP4 panda gets stuck during reboot
In-Reply-To: <45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
References: <20110105140801.GC2304@legolas.emea.dhcp.ti.com>
	<45ff6d061a3e0bdcaf676671bf447b3b@mail.gmail.com>
Message-ID: <20110105141814.GF2304@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 05, 2011 at 07:44:31PM +0530, Santosh Shilimkar wrote:
> > What could it be ? Any more debugging I could do to help ?
> >
> This is known and seems to OMAP specific issue. Test patch and

Doesn't look like omap-specific from patch description. Looks like like
CPU1 is turned off and the instruction to flush PMD entry fails. Could
it be that all ARM SMPs are affected ?

-- 
balbi
