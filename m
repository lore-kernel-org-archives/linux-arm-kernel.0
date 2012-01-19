From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 18:01:21 +0100
Subject: [PATCH V2 04/12] dmaengine/amba-pl08x: Take flow controller info
 from DMA_SLAVE_CONFIG
In-Reply-To: <0bf6d205db66a2e3b8b669f1afdef39788572814.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <0bf6d205db66a2e3b8b669f1afdef39788572814.1326876464.git.viresh.kumar@st.com>
Message-ID: <CACRpkdYuiZk7=V2WvNUJX=b_2hv2=eooGUq__Bz_r8b3JMmgew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 10:11 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Flow controller information is passed now from DMA_SLAVE_CONFIG option. This
> patch makes changes in pl08x driver to use device_fc from it instead of platform
> data.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Viresh,
Linus Walleij
