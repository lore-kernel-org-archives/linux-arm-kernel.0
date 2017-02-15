From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Feb 2017 16:53:00 +0000
Subject: [RFC v2 5/7] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
References: <1487003909-11710-1-git-send-email-arnaud.pouliquen@st.com>
 <1487003909-11710-6-git-send-email-arnaud.pouliquen@st.com>
 <20170214174534.35ytbpax75mxcayg@sirena.org.uk>
 <9b875a75-294a-2f59-5830-cc0f6b3b62c7@st.com>
Message-ID: <20170215165300.wxkzxvq5bjjovgop@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 05:39:53PM +0100, Arnaud Pouliquen wrote:
> On 02/14/2017 06:45 PM, Mark Brown wrote:

> > What's the physical minimum period limit?  The comment makes this 
> > sound like it's just made up.

> I did not find physical minimum period limit, that why i considered
> this value from a scheduling point of view. I will re-check these values.

If there's no physical limit the minimum is one byte, it's the
application's problem if it's not actually able to sustain what it
chooses.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170215/0479c802/attachment.sig>
