From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Jan 2012 15:49:58 +0530
Subject: [PATCH 8/8] dmaengine/dw_dmac: Add support for DMA_SLAVE_CONFIG
In-Reply-To: <CAJe_ZhfYgz5LEO7VqOJ8Qo+PZWrMNNvdfvCGQWMMq-TrbmL+xw@mail.gmail.com>
References: <cover.1326707233.git.viresh.kumar@st.com>
 <7c1e6fd573d5cd348b22f8363c9960fe5efcd658.1326707233.git.viresh.kumar@st.com>
 <4F140D25.1000309@st.com>
 <CAJe_ZhfYgz5LEO7VqOJ8Qo+PZWrMNNvdfvCGQWMMq-TrbmL+xw@mail.gmail.com>
Message-ID: <4F154B4E.2010504@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/17/2012 3:40 PM, Jassi Brar wrote:
> In case at hand since most likely only valid values are power of 2,
> maybe you can do
>     maxburst = ffs(maxburst) - 1

Thanks.

-- 
viresh
