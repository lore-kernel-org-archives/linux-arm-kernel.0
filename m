From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 25 Mar 2016 10:14:25 -0500
Subject: [PATCH v3 01/16] dt: davinci: use proper address after @
In-Reply-To: <1458863503-31121-2-git-send-email-david@lechnology.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-2-git-send-email-david@lechnology.com>
Message-ID: <CAL_Jsq+CrrNnbx9rGhDmjoOkBVo6wjPTVeUcOWSHdLOwWeiC6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 24, 2016 at 6:51 PM, David Lechner <david@lechnology.com> wrote:
> TI has been using the physical address in DT after the @ in device nodes.
> The device tree convention is to use the same address that is used for
> the reg property. This updates all davinci DT files to use the proper
> convention.
>
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>
> v3 changes: This is a new patch.
>
>
>  arch/arm/boot/dts/da850-enbw-cmc.dts |  8 +++---
>  arch/arm/boot/dts/da850-evm.dts      | 26 +++++++++---------
>  arch/arm/boot/dts/da850.dtsi         | 52 ++++++++++++++++++------------------
>  3 files changed, 43 insertions(+), 43 deletions(-)

Thanks for fixing.

Acked-by: Rob Herring <robh@kernel.org>
