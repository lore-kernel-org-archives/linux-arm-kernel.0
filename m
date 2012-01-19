From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 19 Jan 2012 17:59:54 +0100
Subject: [PATCH V2 02/12] dmaengine: Add flow controller information to
 dma_slave_config
In-Reply-To: <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
References: <cover.1326876464.git.viresh.kumar@st.com>
 <5f9ec59562e86536c4123f61891b95590293030f.1326876464.git.viresh.kumar@st.com>
Message-ID: <CACRpkda6-rzCOZkMuagAAxof0FVJMzExnP-QUHtztKM44v=eTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 10:11 AM, Viresh Kumar <viresh.kumar@st.com> wrote:

> Flow controller is programmable for few controllers and there are few
> intelligent peripherals like, Synopsys JPEG controller, that needs to be a flow
> controller of DMA transfers on dest side.
>
> For this, currently two drivers, pl08x and dw_dmac, support flow controller to
> be passed from platform to these drivers.
>
> Perhaps, this should be a part of struct dma_slave_config. This patch adds
> another field device_fc to this structure. User drivers must pass this as true
> if they want to be flow controller of certain transfers.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks Viresh,
Linus Walleij
