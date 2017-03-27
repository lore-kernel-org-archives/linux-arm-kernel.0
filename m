From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Mar 2017 12:59:20 +0100
Subject: [PATCH v3 08/11] ASoC: Add bindings for DMIC codec driver
In-Reply-To: <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-9-git-send-email-arnaud.pouliquen@st.com>
 <20170324144603.zos7n4oqelaag433@rob-hp-laptop>
Message-ID: <20170327115920.opbtui7mor5q6tch@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 24, 2017 at 09:46:03AM -0500, Rob Herring wrote:
> On Fri, Mar 17, 2017 at 03:08:21PM +0100, Arnaud Pouliquen wrote:

> > +Device-Tree bindings for dmic codec

> Please define what is and isn't a DMIC here. What's the interface?

Digital microphones are a well understood concept for anyone familiar
with the problem domain, they all provide a PDM output.

> > +
> > +Required properties:
> > +	- compatible: should be "dmic-codec".

> DMICs don't have part numbers?

Not meaningfully in this context any more than analogue microphones do -
they have no software visible interface.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/9e013c7a/attachment.sig>
