From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 24 Jan 2014 10:35:48 +0530
Subject: [PATCH V2 5/8] clk: SPEAr13xx: Fix pcie clock name
In-Reply-To: <1d96a68894439fa9a571e6234745ab60d4c0f1f5.1390471111.git.mohit.kumar@st.com>
References: <cover.1390471111.git.mohit.kumar@st.com>
 <1d96a68894439fa9a571e6234745ab60d4c0f1f5.1390471111.git.mohit.kumar@st.com>
Message-ID: <CAOh2x==RpXNbo1rh7WUH1iDYXNYNp=zKt9pyN_va9-6R3Hs=qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 4:02 PM, Mohit Kumar <mohit.kumar@st.com> wrote:
> From: Pratyush Anand <pratyush.anand@st.com>
>
> Follow dt clock naming convention for PCIe clocks.
>
> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> Tested-by: Mohit Kumar <mohit.kumar@st.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: spear-devel at list.st.com
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/clk/spear/spear1310_clock.c |    6 +++---
>  drivers/clk/spear/spear1340_clock.c |    2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
