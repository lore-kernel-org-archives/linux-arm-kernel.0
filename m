From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 25 Sep 2012 02:07:44 +1000
Subject: linux-next: Tree for Sept 24 (irqchip)
In-Reply-To: <50607E99.6040303@xenotime.net>
References: <20120925005328.f748dfa3d077cebb345a4291@canb.auug.org.au>
 <50607E99.6040303@xenotime.net>
Message-ID: <20120925020744.cc5beb9e65473605e5ca2240@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Randy,

On Mon, 24 Sep 2012 08:39:05 -0700 Randy Dunlap <rdunlap@xenotime.net> wrote:
>
> On 09/24/2012 07:53 AM, Stephen Rothwell wrote:
> 
> > Today was a train wreck, with lots of new conflicts across several trees
> > and a few build failures as well.
> 
> I agree.  I mostly get this:
> 
> drivers/Kconfig:157: can't open file "drivers/irqchip/Kconfig"
> 
> i.e., no such file.
> 
> How does this happen?  :(
> 
> who handles irqchip?

Hmm, commit 89214f009c1d ("ARM: bcm2835: add interrupt controller
driver") from the arm-soc tree adds that file as an empty file (I have
the empty file in my tree).  Nothing adds anything to it.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/a43debdc/attachment.sig>
