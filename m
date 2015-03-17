From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 17 Mar 2015 09:34:00 +0100
Subject: [PATCH 35/35 linux-next] pinctrl: constify of_device_id array
In-Reply-To: <1426535949-26107-4-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-1-git-send-email-fabf@skynet.be>
 <1426535949-26107-4-git-send-email-fabf@skynet.be>
Message-ID: <5507E6F8.9060109@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/16/2015 08:59 PM, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>   drivers/pinctrl/bcm/pinctrl-bcm2835.c       | 2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt8135.c   | 2 +-
>   drivers/pinctrl/mediatek/pinctrl-mt8173.c   | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-armada-370.c  | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-armada-375.c  | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-armada-38x.c  | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-armada-39x.c  | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-armada-xp.c   | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-kirkwood.c    | 2 +-
>   drivers/pinctrl/mvebu/pinctrl-orion.c       | 2 +-
>   drivers/pinctrl/pinctrl-as3722.c            | 2 +-
>   drivers/pinctrl/pinctrl-at91.c              | 4 ++--
>   drivers/pinctrl/pinctrl-palmas.c            | 2 +-
>   drivers/pinctrl/pinctrl-single.c            | 4 ++--
>   drivers/pinctrl/pinctrl-st.c                | 2 +-
>

For the pinctrl-st driver, you can add my:

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
