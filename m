From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 21 Aug 2017 09:01:52 +0200
Subject: [PATCH v3 4/9] pwm: Add STM32 LPTimer PWM driver
In-Reply-To: <1499445068-7037-5-git-send-email-fabrice.gasnier@st.com>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-5-git-send-email-fabrice.gasnier@st.com>
Message-ID: <20170821070152.GJ18996@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 07, 2017 at 06:31:03PM +0200, Fabrice Gasnier wrote:
> Add support for single PWM channel on Low-Power Timer, that can be
> found on some STM32 platforms.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v3:
> - remove prescalers[] array, use power-of-2 presc directly
> - Update following Thierry's comments:
> - fix issue using FIELD_GET() macro
> - Add get_state() callback
> - remove some checks in probe
> - slight rework 'reenable' flag
> - use more common method to disable pwm in remove()
> 
> Changes in v2:
> - s/Low Power/Low-Power
> - update few comment lines
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-stm32-lp.c | 246 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32-lp.c

Sorry, this fell through the cracks: changes in v3 look good to me:

Acked-by: Thierry Reding <thierry.reding@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170821/6dbb14ed/attachment.sig>
