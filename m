From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 18:00:43 +0100
Subject: [PATCH V2 03/12] dmaengine: Pass dma_slave_config .device_fc =
 NULL for all existing users
In-Reply-To: <104f6d8b3c4a2d65dce9eb32364d32eba637c48d.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <104f6d8b3c4a2d65dce9eb32364d32eba637c48d.1326876464.git.viresh.kumar@st.com>
Message-ID: <CACRpkdYjLyYx-pDLA+FqT+=Vdop4jF4+ex6D6o9udNbN57+=Zg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 10:11 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> .device_fc is added in struct dma_slave_config recently. All user drivers, which
> want DMA to be the flow controller must pass this field as false. As earlier
> driver don't look to use this feature, mark it false for now.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Viresh,
Linus Walleij
