From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Jun 2013 13:57:56 +0200
Subject: [PATCH v3 03/10] pinctrl:st: Add pinctrl and pinconf support.
In-Reply-To: <51C45816.5010207@st.com>
References: <1371736996-8770-1-git-send-email-srinivas.kandagatla@st.com>
 <1371737138-9340-1-git-send-email-srinivas.kandagatla@st.com>
 <51C45816.5010207@st.com>
Message-ID: <CACRpkdb-H2=GdF54Fay+PQVdXLTs++L5+QYe_vFPuzpa+E4ZMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 3:41 PM, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:

> Hi Linus W,
> If its not too late can this patch be considered for 3.11 via pinctrl tree?
> There is a build dependecy with regmap_field apis pulled by Mark Brown
> in regmap repository.

This seems fairly complete, but I cannot have such a basic dependency onto
the regmap tree this late in the merge window, i.e. I'm not ready to pull
all of regmap into the pinctrl tree. I'd consider this for merging
for the next kernel cycle so it's more orthogonal.

Yours,
Linus Walleij
