From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 30 Aug 2016 17:14:32 -0500
Subject: [PATCH 0/3] remove skeleton.dtsi from armv7-m.dtsi
In-Reply-To: <20160830205250.15616-1-manabian@gmail.com>
References: <20160830205250.15616-1-manabian@gmail.com>
Message-ID: <CAL_Jsq+dLpOVHECqb9j3axhxwRPAbKXmyFiOKPVM51P3819XaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 3:52 PM, Joachim Eastwood <manabian@gmail.com> wrote:
> Hi
>
> This patch set removes skeleton.dtsi from the common ARM Cortex-M dtsi.
> This will allow us to remove skeleton.dtsi on a per platform basis and
> get rid of the unit address warning on the memory nodes without getting
> duplicate memory nodes.
>
> See 3ebee5a2e141 ("arm64: dts: kill skeleton.dtsi") for additional
> reasons not to use the skeleton.dtsi.
>
> I plan to take atleast the first two patches through the lpc18xx tree.
> Please ack if you are okey with the change to your platform dtsi file.
>
>
> Joachim Eastwood (3):
>   ARM: dts: armv7-m: remove skeleton.dtsi include
>   ARM: dts: lpc18xx: remove skeleton.dtsi include and fix unit address warnings
>   ARM: dts: efm32: remove skeleton.dtsi include and fix unit address warnings

For the series,

Acked-by: Rob Herring <robh@kernel.org>
