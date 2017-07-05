From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 5 Jul 2017 13:19:57 -0300
Subject: [RESEND PATCH] ARM: dts: imx: update snvs-poweroff mask
In-Reply-To: <20170704161912.29618-1-m.niestroj@grinn-global.com>
References: <20170704161912.29618-1-m.niestroj@grinn-global.com>
Message-ID: <CAOMZO5DMuv-VEBOT4QNAdGn=e2qGS3ZcrJ6ZOvYMuBkzdB_Ejg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 4, 2017 at 1:19 PM, Marcin Niestroj
<m.niestroj@grinn-global.com> wrote:
> From: Guy Shapiro <guy.shapiro@mobi-wize.com>
>
> Make the syscon-poweroff driver change only the shutdown bits on the
> SNVS_LP control register.
>
> This change fixes an issue with the RTC wakeup alarm, that was
> previously disabled during power off.
>
> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
> Reviewed-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
