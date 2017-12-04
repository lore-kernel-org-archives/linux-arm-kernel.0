From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Dec 2017 16:58:54 +0000
Subject: [PATCH v6 13/13] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <bd2ba77f-2d91-efb7-d89a-3f8cdeb941f7@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
 <1512150020-20335-14-git-send-email-arnaud.pouliquen@st.com>
 <20171202150952.1b5f3bfd@archlinux>
 <bd2ba77f-2d91-efb7-d89a-3f8cdeb941f7@st.com>
Message-ID: <20171204165854.m75tpfauxxwz6bi4@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 04, 2017 at 09:58:42AM +0100, Arnaud Pouliquen wrote:
> On 12/02/2017 04:09 PM, Jonathan Cameron wrote:

> > Mark, given this set is moderately invasive on the IIO side and
> > should just drop in cleanly on the sound side of things, either
> > I could take it via IIO or one of us can do an immutable branch
> > and we take it through both trees.

> Don't know if you saw the reply from Mark on V5:
> "This is basically fine, if someone could send me a pull request and the
> relevant patches when the IIO stuff is sorted out I'll give it a final
> check and apply then."

Yup, I figure that a shared branch with the IIO changes in will be the
easiest thing (Morimoto-san is donig a bunch of subsystem wide ASoC
cleanups ATM).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171204/2dfc1c87/attachment.sig>
