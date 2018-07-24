From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 24 Jul 2018 14:36:14 +1000
Subject: [PATCH 1/5] arm: dts: aspeed: Add coprocessor interrupt controller
In-Reply-To: <CACPK8Xe53YJ6GmEk6gyN5DNgEHn5V+CGNSKNE-MNw8Osugf2=Q@mail.gmail.com>
References: <20180724042406.15374-1-benh@kernel.crashing.org>
 <20180724042406.15374-2-benh@kernel.crashing.org>
 <CACPK8Xe53YJ6GmEk6gyN5DNgEHn5V+CGNSKNE-MNw8Osugf2=Q@mail.gmail.com>
Message-ID: <c76640c2d99e9c8b1e3dab664de8ad36d0eb0da3.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-24 at 13:59 +0930, Joel Stanley wrote:
> On 24 July 2018 at 13:54, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > Add the missing node for the CVIC (the coprocessor interrupt
> > controller) and add a label to the SRAM node so it can be
> > referenced from the board device-tree file.
> > 
> > OpenBMC-Staging-Count: 1
> 
> We shouldn't be putting this in upstream patches.

Ah oops, I accidentally cherry-picked it back out of your tree.

> I can drop it when I apply if there is no other review.
