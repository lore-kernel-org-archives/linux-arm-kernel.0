From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Apr 2017 15:32:50 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
Message-ID: <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 02:48:32PM -0500, Rob Herring wrote:
> On Thu, Apr 06, 2017 at 05:40:35PM +0200, olivier moysan wrote:

> > +Required properties:
> > +  - compatible: Must be "st,stm32h7-i2s"
> > +  - #sound-dai-cells: Must be 1. (one parameter)
> > +    This parameter allows to specify CPU DAI index in soundcard CPU dai link.
> > +	index 0: playback DAI
> > +	index 1: capture DAI
> > +	index 2: full duplex DAI

> Is this still needed for graph-card?

The graph card is blocked on your review...  I'm also not clear how
without something like this we'd be able to identify a specific DAI
within a device if we don't have a way of identifying them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170411/493117dc/attachment.sig>
