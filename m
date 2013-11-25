From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 25 Nov 2013 10:40:44 +0100
Subject: [RFC PATCH 0/3] DT support for ST micro accelerometers and
 gyroscopes
In-Reply-To: <52926901.9080004@kernel.org>
References: <1384876234-1211-1-git-send-email-maxime.ripard@free-electrons.com>
 <528DF164.8060009@st.com> <20131121131402.GF1029@lukather>
 <52926901.9080004@kernel.org>
Message-ID: <20131125094044.GE3176@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

On Sun, Nov 24, 2013 at 09:00:49PM +0000, Jonathan Cameron wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/21/13 13:14, Maxime Ripard wrote:
> > Hi Denis,
> > 
> > On Thu, Nov 21, 2013 at 12:41:24PM +0100, Denis CIOCCA wrote:
> > > only one point: it's possible to use the same names with DT?
> > > (using _ instead of -)
> > 
> > Yes, it is, but only for i2c as far as I'm aware, and usually the
> > DT compatibles are with - as a separator (I looked into the ePAPR,
> > but couldn't get any explanations or requirements on this, even
> > though it's used in all of their examples)
> 
> In other discussions, where the defacto i2c device tree bindings have
> been followed, the conclusion has been that to change to a - from _
> would result in userspace ABI changes, so whilst no one wants _
> the discussion has concluded we can't really avoid it.

What kind of userspace ABI changes are we talking about?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/175727d9/attachment.sig>
