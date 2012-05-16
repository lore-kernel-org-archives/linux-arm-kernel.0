From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 16 May 2012 08:53:23 +0100
Subject: [PATCH] clk: wm831x: Add initial WM831x clock driver
In-Reply-To: <CAJOA=zMRRJB5HZhQPNBbAc0+U=Rgs9v0feDqK-6VRUzGnUEbyA@mail.gmail.com>
References: <1337004985-22549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAJOA=zMRRJB5HZhQPNBbAc0+U=Rgs9v0feDqK-6VRUzGnUEbyA@mail.gmail.com>
Message-ID: <20120516075322.GA6801@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 10:00:51PM -0700, Turquette, Mike wrote:
> On Mon, May 14, 2012 at 7:16 AM, Mark Brown
> > The WM831x and WM832x series of PMICs contain a flexible clocking
> > subsystem intended to provide always on and system core clocks. ?It
> > features:

> Do you plan to rebase against my clk-next branch?  I've pushed your
> clk_unregister patch there.

I guess; I had removed the unregistration from the driver partly to
split out the unregistration so the driver could get merged separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/f3b57a06/attachment.sig>
