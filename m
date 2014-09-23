From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 23 Sep 2014 09:27:32 +0200
Subject: [PATCH 0/3] media:st-rc: Misc fixes.
In-Reply-To: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1411424501-12673-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <542120E4.5030403@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srini,

	Thanks for sending these fixes.

	For the series, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Regards,
Maxime

On 09/23/2014 12:21 AM, Srinivas Kandagatla wrote:
> Hi Mauro,
>
> Thankyou for the "[media] enable COMPILE_TEST for media drivers" patch
> which picked up few things in st-rc driver in linux-next testing.
>
> Here is a few minor fixes to the driver, could you consider them for
> the next merge window.
>
> Thanks,
> srini
>
> Srinivas Kandagatla (3):
>    media: st-rc: move to using reset_control_get_optional
>    media: st-rc: move pm ops setup out of conditional compilation.
>    media: st-rc: Remove .owner field for driver
>
>   drivers/media/rc/st_rc.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
