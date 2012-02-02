From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Feb 2012 09:24:57 -0200
Subject: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Thu, Feb 2, 2012 at 12:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
> ?arch/arm/boot/dts/imx6q-sabrelite.dts | ? 12 ++++++++++++
> ?1 files changed, 12 insertions(+), 0 deletions(-)

I would like to test your audio support patch on mx6sabrelite, but the
missing sound/soc/imx-sgtl5000.c does not allow me to do it.

I think you would better introduce sound/soc/imx-sgtl5000.c first (on
separate patch series) so that people could test this patch without
using the imx-sgtl5000.c implementation from the Linaro kernel.

Without imx-sgtl5000.c in place, this patch only introduces dead code
at the moment.

Regards,

Fabio Estevam
