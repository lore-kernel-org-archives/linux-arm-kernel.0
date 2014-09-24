From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Sep 2014 09:14:55 +0100
Subject: regulator node names and unit-addresses? (Re: [PATCH v2 1/5]
 ARM: shmobile: kzm9d: Remove spurious regulator base addresses)
In-Reply-To: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
References: <CAMuHMdVC2h4_Q+4BpV5iLbhfviimzrnfZ3+c6dqnegTAxBHw_g@mail.gmail.com>
Message-ID: <20140924081455.GU4015@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 09:02:23AM +0200, Geert Uytterhoeven wrote:
> On Wed, Sep 24, 2014 at 3:13 AM, Simon Horman <horms@verge.net.au> wrote:

> > What should we call the nodes?

> "regulator0" and "regulator1"?
> "regulator1v8" and "regulator3v3"?

> Documentation/devicetree/bindings/regulator/regulator.txt doesn't mention
> node names or (presence/lack of) unit-adresses, but the examples do have
> unit-addresses.

> Is this another case where we don't follow the "no reg, no unit-address"
> ePAPR rule?

As far as the regulator API is concerned the node name is completly
immaterial and all this stuff is just verbiage we're forced to include.
As far as I can tell the requirement that node names be in the form
"regulator" or whatever is just another thing that wasn't terribly well
thought through in ePAPR, they were trying to do classes I think.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/ab0007ee/attachment.sig>
