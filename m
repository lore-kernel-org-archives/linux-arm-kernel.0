From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 1 Feb 2017 16:47:11 +0100
Subject: [PATCH RESEND 4/5] mtd: nand: atmel: Document the new DT bindings
In-Reply-To: <20170201153920.g26erfzxnxrmsu4z@rob-hp-laptop>
References: <1485535324-28393-1-git-send-email-boris.brezillon@free-electrons.com>
 <1485535324-28393-5-git-send-email-boris.brezillon@free-electrons.com>
 <20170201153920.g26erfzxnxrmsu4z@rob-hp-laptop>
Message-ID: <20170201164711.27e4b600@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Feb 2017 09:39:20 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Jan 27, 2017 at 05:42:03PM +0100, Boris Brezillon wrote:
> > Document the new DT bindings for the Atmel NAND controller and
> > deprecate the old ones.  
> 
> Why?

Because the existing representation is not only wrong, it also causes
pinmux conflicts between the NAND controller and other devices present
on the EBI bus.
It's explained in the cover letter, but maybe you want me to put that
in the commit message.

> 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  .../devicetree/bindings/mtd/atmel-nand.txt         | 106 ++++++++++++++++++++-
> >  1 file changed, 105 insertions(+), 1 deletion(-)  
