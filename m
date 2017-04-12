From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 12:32:51 +0100
Subject: [PATCH 1/2] dt-bindings: Document STM32 I2S bindings
In-Reply-To: <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
References: <1491493236-2574-1-git-send-email-olivier.moysan@st.com>
 <1491493236-2574-2-git-send-email-olivier.moysan@st.com>
 <20170410194832.iivnkyejtywbe2c7@rob-hp-laptop>
 <20170411143250.3r7ys3rjshtxgaee@sirena.org.uk>
 <73caede5-ea6f-8b2b-2270-227f7ef31823@st.com>
 <20170411211040.htrcedus3c57fbed@sirena.org.uk>
 <86a179ad-7961-18f7-8050-25e0e584c77d@st.com>
Message-ID: <20170412113251.nfyk5sw6c5pnpmwr@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 08:30:31AM +0000, Olivier MOYSAN wrote:
> On 04/11/2017 11:10 PM, Mark Brown wrote:

> > That sounds wrong, I'd expect this wiring to be done statically as part
> > of the .dtsi for the SoC (or just grabbed as needed at runtime if
> > things are flexbile enough) rather than being a configuration thing done
> > per board...  I had thought that this was configuration reflecting
> > different ways of taping out the IP with different feature sets, is that
> > not the case?

> This configuration is board dependent. The IP may be used as rx, tx or 
> fd depending on board. So I think it can make sense to have a DMA 
> configuration linked to board, and to set IP mode accordingly.

It is totally normal to just not use one direction in a given system, we
don't normally need to do anything special to handle things.  I'm a bit
confused as to what's different here and needs configuring?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/7caea188/attachment.sig>
