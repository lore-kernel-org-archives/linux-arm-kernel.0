From: viresh.kumar@linaro.org (viresh kumar)
Date: Mon, 16 Jul 2012 09:01:29 +0100
Subject: [PATCH v2 0/4] Clk: SPEAr: Rename clk ids within predefined limit
In-Reply-To: <cover.1342411982.git.vipulkumar.samar@st.com>
References: <cover.1342411982.git.vipulkumar.samar@st.com>
Message-ID: <CAOh2x=k1YifBUL4Wr78YJQNyLv4i8nOLdCChEHWBJ0thv5u98A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 5:25 AM, Vipul Kumar Samar
<vipulkumar.samar@st.com> wrote:
> The max limit of con_id is 16 and dev_id is 20. As of now for all SPEAr SOC's
> clk ids are exceeding this predefined limit.
>
> This patch set is intended to rename clk ids through out spear clk framework.
>
> -v2:
> -Rename gpt timer parent clk id on spear3xx and spear6xx machine as pll3_48m_clk
> is renamed to pll3_clk.
>
>
> Vipul Kumar Samar (4):
>   clk:spear1340:Fix: Rename clk ids within predefined limit
>   clk:spear1310:Fix: Rename clk ids within predefined limit
>   Clk:spear3xx:Fix: Rename clk ids within predefined limit
>   Clk:spear6xx:Fix: Rename clk ids within predefined limit

Looks Good.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
