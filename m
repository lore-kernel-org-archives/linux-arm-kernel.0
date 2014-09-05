From: robherring2@gmail.com (Rob Herring)
Date: Fri, 5 Sep 2014 07:46:19 -0500
Subject: [PATCH 5/6] dts, arm64: Move dts files to vendor subdirs
In-Reply-To: <1409899692-1455-6-git-send-email-rric@kernel.org>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <1409899692-1455-6-git-send-email-rric@kernel.org>
Message-ID: <CAL_JsqLJ+zuqx9RELw3p2Pa13QuXsDR3Fv1Qcaeqk+R6HXy9uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 5, 2014 at 1:48 AM, Robert Richter <rric@kernel.org> wrote:
> From: Robert Richter <rrichter@cavium.com>
>
> Moving dts files to vendor subdirs.
>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  arch/arm64/boot/dts/Makefile                     |   4 +-
>  arch/arm64/boot/dts/apm-mustang.dts              |  34 --
>  arch/arm64/boot/dts/apm-storm.dtsi               | 425 -----------------------
>  arch/arm64/boot/dts/apm/Makefile                 |   5 +
>  arch/arm64/boot/dts/apm/apm-mustang.dts          |  34 ++
>  arch/arm64/boot/dts/apm/apm-storm.dtsi           | 425 +++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/Makefile                 |   6 +
>  arch/arm64/boot/dts/arm/foundation-v8.dts        | 232 +++++++++++++
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts       | 159 +++++++++
>  arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 240 +++++++++++++
>  arch/arm64/boot/dts/foundation-v8.dts            | 232 -------------
>  arch/arm64/boot/dts/rtsm_ve-aemv8a.dts           | 159 ---------
>  arch/arm64/boot/dts/rtsm_ve-motherboard.dtsi     | 240 -------------
>  13 files changed, 1103 insertions(+), 1092 deletions(-)

This should be sent with renames enabled (-M option). You can enable
it by default with this in your git config:

[diff]
        renames = true

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

Rob
