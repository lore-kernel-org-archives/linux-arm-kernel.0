From: dann.frazier@canonical.com (Dann Frazier)
Date: Wed, 2 Apr 2014 19:16:29 -0600
Subject: [PATCH v2 0/3] rtc: Add APM X-Gene SoC RTC driver
In-Reply-To: <1396287370-1011-1-git-send-email-lho@apm.com>
References: <1396287370-1011-1-git-send-email-lho@apm.com>
Message-ID: <CALdTtnvxGjF6tMWEOuRqSRsM+2av6i5JeEfaHMRbj28OuTNq=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: dann frazier <dann.frazier@canonical.com>

On Mon, Mar 31, 2014 at 11:36 AM, Loc Ho <lho@apm.com> wrote:
> This patch adds support for the APM X-Gene SoC RTC driver.
>
> v2
> * Change function xgene_rtc_read_time to return rtc_valid_tm(tm) instead 0
>
> v1
> * Initial version
>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> ---
> Loc Ho (3):
>   Documentation: Add documentation for the APM X-Gene SoC RTC DTS
>     binding
>   rtc: Add APM X-Gene SoC RTC driver
>   arm64: Add APM X-Gene SoC RTC DTS entry
>
>  .../devicetree/bindings/rtc/xgene-rtc.txt          |   28 ++
>  arch/arm64/boot/dts/apm-storm.dtsi                 |   21 ++
>  drivers/rtc/Kconfig                                |    9 +
>  drivers/rtc/Makefile                               |    1 +
>  drivers/rtc/rtc-xgene.c                            |  278 ++++++++++++++++++++
>  5 files changed, 337 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/xgene-rtc.txt
>  create mode 100644 drivers/rtc/rtc-xgene.c
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
