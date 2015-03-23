From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 23 Mar 2015 09:59:59 +0100
Subject: [PATCH] ARM: tegra: use generated pinmux for Beaver board
In-Reply-To: <1426794762.2212.0.camel@lynxeye.de>
References: <1420495066-19221-1-git-send-email-dev@lynxeye.de>
 <54AB0B68.7050704@wwwdotorg.org>
 <1420591830.25483.16.camel@lynxeye.de>
 <1425323769.2182.0.camel@lynxeye.de>
 <1426794762.2212.0.camel@lynxeye.de>
Message-ID: <20150323085958.GA11268@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 08:52:42PM +0100, Lucas Stach wrote:
> Am Montag, den 02.03.2015, 20:16 +0100 schrieb Lucas Stach:
> > Am Mittwoch, den 07.01.2015, 01:50 +0100 schrieb Lucas Stach:
> > > Am Montag, den 05.01.2015, 15:08 -0700 schrieb Stephen Warren:
> > > > On 01/05/2015 02:57 PM, Lucas Stach wrote:
> > > > > Replace the current incomplete pinmux setup with a proper one generated
> > > > > using the tegra pinmux scripts.
> > > > 
> > > > I assume this is identical to the existing content, it's just that the 
> > > > node sort order changed to match the auto-generation order?
> > > > 
> > > Yes auto-generation changes the representation of the nodes a bit, but I
> > > made sure to keep the properties of the existing kernel DT pinmux where
> > > they were different from the U-Boot pinmux.
> > > 
> > > > If so,
> > > > Acked-by: Stephen Warren <swarren@nvidia.com>
> > > 
> > This has not been applied. Could anyone please pick this up, so it
> > doesn't miss yet another merge window?
> > 
> Friendly ping.

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150323/852d9787/attachment.sig>
