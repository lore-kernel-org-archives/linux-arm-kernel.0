From: tfiga@chromium.org (Tomasz Figa)
Date: Thu, 8 Mar 2018 19:29:21 +0900
Subject: [PATCH v6 00/17] Rockchip ISP1 Driver
In-Reply-To: <20180308094807.9443-1-jacob-chen@iotwrt.com>
References: <20180308094807.9443-1-jacob-chen@iotwrt.com>
Message-ID: <CAAFQd5D1FMm4FTugstxk_6bE-QbLeNsMZM6EaVVfN_mu8_RQUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2018 at 6:47 PM, Jacob Chen <jacob-chen@iotwrt.com> wrote:
> From: Jacob Chen <jacob2.chen@rock-chips.com>
>
> changes in V6:
>   - add mipi txrx phy support
>   - remove bool and enum from uapi header
>   - add buf_prepare op
>   - correct some spelling problems
>   - return all queued buffers when starting stream failed

Thanks Jacob.

For anyone planning to review, especially Hans, who pointed it out in
previous version, g_mbus_config is still there and we're working on
replacing it with something less controversial.

Best regards,
Tomasz
