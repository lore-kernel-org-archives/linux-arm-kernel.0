From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 15:04:35 +0800
Subject: [PATCH v4 23/26] devicetree: fix a series of wrong file references
In-Reply-To: <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
References: <cover.1529079119.git.mchehab+samsung@kernel.org>
 <266e5f874b36aa83f3327879d85921fab52d5461.1529079120.git.mchehab+samsung@kernel.org>
Message-ID: <CAGb2v65+6zV1E--KvD3Si=XNmDE3oaZ2hBxvm86KjTwUv9BnSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 16, 2018 at 12:30 AM, Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> As files got renamed, their references broke.
>
> Manually fix a series of broken refs at the DT bindings.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  .../devicetree/bindings/input/rmi4/rmi_2d_sensor.txt |  2 +-
>  Documentation/devicetree/bindings/mfd/sun6i-prcm.txt |  2 +-

If still applicable,

Acked-by: Chen-Yu Tsai <wens@csie.org>
