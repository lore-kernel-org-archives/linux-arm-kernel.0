From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 17 Mar 2014 17:29:57 +0100
Subject: [GIT PULL] Allwinner core additions for 3.15
In-Reply-To: <201403171443.47557.arnd@arndb.de>
References: <20140313164327.GA13229@lukather>
 <201403171443.47557.arnd@arndb.de>
Message-ID: <20140317162957.GQ27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 02:43:47PM +0100, Arnd Bergmann wrote:
> On Thursday 13 March 2014, Maxime Ripard wrote:
> > The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> > 
> >   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://github.com/mripard/linux.git tags/sunxi-core-for-3.15
> > 
> > for you to fetch changes up to 8db21ad469fda194913db2c5b11635bcc21345fc:
> > 
> >   ARM: sunxi: Add the new watchog compatibles to the reboot code (2014-03-13 11:46:20 +0100)
> > 
> 
> Merged into next/soc, thanks!
> 
> Just for confirmation, I noticed that you are removing the previous "compatible"
> strings from sunxi_restart_ids. Is that intentional? It seems like you risk
> breaking backwards compatibility.

Yes. Since we are adding new devices at a relatively high rate these
days, users will upgrade their DT anyway. Obviously, it will be the
last time we're doing such a change.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/99379e0d/attachment.sig>
