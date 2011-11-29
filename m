From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Nov 2011 09:41:41 +0100
Subject: [PATCH] dmaengine/amba-pl08x: Config ccfg and increment
 phychan_hold if phychan is true
In-Reply-To: <fc4d77e6355cc462cfc2e700415cd56b9db816cb.1322551469.git.viresh.kumar@st.com>
References: <fc4d77e6355cc462cfc2e700415cd56b9db816cb.1322551469.git.viresh.kumar@st.com>
Message-ID: <CACRpkdZASL_TKjX+w=+Y9qutJKSk1JNd0Vou3iZXDXO9+td9Yw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 8:26 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Currently, if plchan->phychan is true, we return immediately from
> prep_phy_chan(). We must configure txd->ccfg and increment phychan_hold before
> returning. Otherwise, request line number wouldn't be configured in this txd.
>
> Reported-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
