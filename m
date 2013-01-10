From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Thu, 10 Jan 2013 21:21:27 +0100
Subject: [PATCH 11/14] ARM: tegra: tamonten: Add PCIe support
In-Reply-To: <201301092123.37491.arnd@arndb.de>
References: <1357764194-12677-1-git-send-email-thierry.reding@avionic-design.de>
 <1357764194-12677-12-git-send-email-thierry.reding@avionic-design.de>
 <201301092123.37491.arnd@arndb.de>
Message-ID: <20130110202127.GB26139@avionic-0098.adnet.avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 09:23:37PM +0000, Arnd Bergmann wrote:
> On Wednesday 09 January 2013, Thierry Reding wrote:
> > Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> > ---
> >  arch/arm/boot/dts/tegra20-tamonten.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> It's not clear how this one-line patch adds PCIe support to the
> platform. Are you missing the actual change here?

This is really just required to associate a name with the regulator, but
I think I can achieve the same by adding an alias to the TEC DTSI.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130110/e3b5beab/attachment.sig>
