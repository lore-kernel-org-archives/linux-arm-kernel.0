From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Nov 2014 14:16:34 +0100
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <5826341.lADJtgptEV@wuerfel>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <5476EA0A.7090406@arm.com> <20141127120826.GA25222@ulmo>
 <5826341.lADJtgptEV@wuerfel>
Message-ID: <20141127131632.GA7643@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 02:02:48PM +0100, Arnd Bergmann wrote:
> On Thursday 27 November 2014 13:08:28 Thierry Reding wrote:
> > 
> > > I'd be tempted to consider it as a fix for 3.18, as the current code is
> > > obviously wrong. Just let me know how you want to get it in.
> > 
> > That's fine with me:
> > 
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > 
> > Arnd, is this anything you could pick up for 3.18?
> > 
> 
> Sure, no problem. Applied to fixes branch now.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/ae2072c8/attachment.sig>
