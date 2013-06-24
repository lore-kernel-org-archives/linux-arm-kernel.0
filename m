From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Jun 2013 15:12:57 +0100
Subject: [PATCH v3 03/10] pinctrl:st: Add pinctrl and pinconf support.
In-Reply-To: <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
 <51C45816.5010207@st.com>
 <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
Message-ID: <20130624141257.GM27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 01:57:56PM +0200, Linus Walleij wrote:

> This seems fairly complete, but I cannot have such a basic dependency onto
> the regmap tree this late in the merge window, i.e. I'm not ready to pull
> all of regmap into the pinctrl tree. I'd consider this for merging
> for the next kernel cycle so it's more orthogonal.

I've got the patch on a topic branch in regmap to allow for this sort of
stuff - I can readily provide a signed tag for you to get just that
patch if that'd help?  Alternatively I'm happy to carry the pinctrl
patch in regmap?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130624/f97ca77b/attachment.sig>
