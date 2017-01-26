From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Jan 2017 12:50:31 -0200
Subject: [PATCH 2/2] clk: imx7d: Add the IPG root clock
In-Reply-To: <CAOi56cUrAyqV3e1zW+UGNRfGaueJr9yH1md3DPJT6vVM_zfpTA@mail.gmail.com>
References: <1484762037-10737-1-git-send-email-fabio.estevam@nxp.com>
 <1484762037-10737-2-git-send-email-fabio.estevam@nxp.com>
 <CAOi56cUrAyqV3e1zW+UGNRfGaueJr9yH1md3DPJT6vVM_zfpTA@mail.gmail.com>
Message-ID: <CAOMZO5CTrO2kEgxg=-KamZb5HXEoy18T0yDDxGQ4b9oscjU2_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Jan 26, 2017 at 3:24 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Hi Fabio,
>
> On Wed, Jan 18, 2017 at 9:53 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
>> Add an entry for the IMX7D_IPG_ROOT clock.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>
> kernelci.org started detecting boot failures on imx7s-warp in
> next-20160124[1], and I bisected it down to this patch, which is in
> linux-next as commit dde08302c083.
>
> I verified that reverting that commit on top of next-20160124 gets
> imx7s-warp booting again.

Thanks for the report.

Stephen, could you please drop this patch from your tree? I will
investigate the issue.
