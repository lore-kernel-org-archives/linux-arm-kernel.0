From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Jun 2011 16:16:55 +0300
Subject: [PATCH 3.0-rc2] OMAP: ams-delta: fix broken uevent sysfs entries
In-Reply-To: <201106151514.11574.jkrzyszt@tis.icnet.pl>
References: <201106070316.41099.jkrzyszt@tis.icnet.pl>
	<201106151453.07945.jkrzyszt@tis.icnet.pl>
	<20110615130005.GM471@legolas.emea.dhcp.ti.com>
	<201106151514.11574.jkrzyszt@tis.icnet.pl>
Message-ID: <20110615131654.GS471@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jun 15, 2011 at 03:14:04PM +0200, Janusz Krzysztofik wrote:
> > > How would you like to have this corrected then?
> > 
> > I guess removing __initdata from all platoform_device structures is
> > the way to go. We need to find another way to silent the section
> > mismatch warnings.
> 
> OK. I'll cook a patch which removes __initdata from all listed above 
> instead of only from board-ams-delta.

you can add my Acked-by line if you wish:

Acked-by: Felipe Balbi <balbi@ti.com>

and thanks for going through all this ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110615/d83eae29/attachment.sig>
