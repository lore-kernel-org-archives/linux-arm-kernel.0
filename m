From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Tue, 5 Jun 2018 22:35:10 +0200
Subject: [PATCH v2 12/16] dt-bindings/interrupt-controller: update
 Marvell ICU bindings
In-Reply-To: <20180605202902.GA8875@rob-hp-laptop>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
 <20180522094042.24770-13-miquel.raynal@bootlin.com>
 <20180605202902.GA8875@rob-hp-laptop>
Message-ID: <20180605223510.0249b86c@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 5 Jun 2018 14:29:02 -0600, Rob Herring wrote:
> On Tue, May 22, 2018 at 11:40:38AM +0200, Miquel Raynal wrote:
> > Change the documentation to reflect the new bindings used for Marvell
> > ICU. This involves describing each interrupt group as a subnode of the
> > ICU node. Each of them having their own compatible.  
> 
> Need to explain why you need to do this and why breaking backwards 
> compatibility is okay.

It does not break backward compatibility. The driver changes keep
support for the previous DT binding where there was a single node with
no subnodes.

The DT binding documentation still documents the legacy binding,
because it is still supported, and still works.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
