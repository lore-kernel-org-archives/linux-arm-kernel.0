From: broonie@kernel.org (Mark Brown)
Date: Sat, 21 Oct 2017 11:16:07 +0100
Subject: [INTERNAL][PATCH 4/7] ASoC: stm32: sai: fix stop management in isr
In-Reply-To: <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
References: <1508418203-16840-1-git-send-email-olivier.moysan@st.com>
 <1508418203-16840-5-git-send-email-olivier.moysan@st.com>
Message-ID: <20171021101607.uwnt4wniycthdld3@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 03:03:20PM +0200, Olivier Moysan wrote:
> Add check on substream validity.

Fixes should go at the start of the series so they can be applied
separately and sent to Linus without having to wait for new features.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171021/7472ee7a/attachment.sig>
