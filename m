From: robh@kernel.org (Rob Herring)
Date: Mon, 17 Jul 2017 12:04:57 -0500
Subject: [PATCH] dt-bindings: clock: ti-sci: Fix incorrect usage of headers
In-Reply-To: <20170712010923.GP22780@codeaurora.org>
References: <20170711223615.29398-1-s-anna@ti.com>
 <20170712010923.GP22780@codeaurora.org>
Message-ID: <20170717170457.4pkb6qaa3qbept5n@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 06:09:23PM -0700, Stephen Boyd wrote:
> On 07/11, Suman Anna wrote:
> > The clock consumer usage description was erroneously referring to
> > couple of dt-binding headers that are no longer valid. The definition
> > and/or usage of these headers is incorrect and the only file present
> > at the moment, dt-bindings/soc/k2g.h is also being cleaned up. The
> > examples in this binding were updated properly, but the update to
> > description was missed out. So, fix this.
> > 
> > Fixes: 8f306cfe4383 ("Documentation: dt: Add TI SCI clock driver")
> > Signed-off-by: Suman Anna <s-anna@ti.com>
> > ---
> > Hi Stephen,
> > 
> > Looks like this was missed during the update/repost of the ti-sci-clk
> > driver/binding. FYI, Santosh is going to pickup the header file cleanup
> > patch https://patchwork.kernel.org/patch/9741279/ for the next merge
> > window.
> 
> I'll let Rob apply this as it is purely a binding document update.

Applied.

Rob
