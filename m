From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 25 Apr 2016 16:57:32 -0600
Subject: [PATCH 02/41] Documentation: sysfs: fix spelling mistakes
In-Reply-To: <1461543878-3639-3-git-send-email-eric@engestrom.ch>
References: <1461543878-3639-1-git-send-email-eric@engestrom.ch>
 <1461543878-3639-3-git-send-email-eric@engestrom.ch>
Message-ID: <CANLsYkxYp6hNtX4vRCaH6HdcxzHvfcUFGG_OJFc22mF2YeJX=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 April 2016 at 18:23, Eric Engestrom <eric@engestrom.ch> wrote:
> Signed-off-by: Eric Engestrom <eric@engestrom.ch>
> ---
>  Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x      | 2 +-
>  Documentation/ABI/testing/sysfs-bus-event_source-devices-events  | 4 ++--
>  Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 | 2 +-
>  Documentation/ABI/testing/sysfs-driver-tegra-fuse                | 2 +-
>  Documentation/ABI/testing/sysfs-fs-xfs                           | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> index 2355ed8..19b83f4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etm4x
> @@ -378,7 +378,7 @@ Date:               April 2015
>  KernelVersion: 4.01
>  Contact:       Mathieu Poirier <mathieu.poirier@linaro.org>
>  Description:   (R) Returns the maximum size of the data value, data address,
> -               VMID, context ID and instuction address in the trace unit
> +               VMID, context ID and instruction address in the trace unit
>                 (0x1E8).  The value is taken directly from the HW.

For this part: Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>
>  What:          /sys/bus/coresight/devices/<memory_map>.etm/trcidr/trcidr3
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index 505f080..77de58d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -47,7 +47,7 @@ Description:  Per-pmu performance monitoring events specific to the running syste
>                 If a <term> is specified alone (without an assigned value), it
>                 is implied that 0x1 is assigned to that <term>.
>
> -               Examples (each of these lines would be in a seperate file):
> +               Examples (each of these lines would be in a separate file):
>
>                         event=0x2abc
>                         event=0x423,inv,cmask=0x3
> @@ -83,7 +83,7 @@ Description:  Perf event scaling factors
>
>                 A string representing a floating point value expressed in
>                 scientific notation to be multiplied by the event count
> -               recieved from the kernel to match the unit specified in the
> +               received from the kernel to match the unit specified in the
>                 <event>.unit file.
>
>                 Example:
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> index f893337..ec27c6c 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> @@ -4,7 +4,7 @@ Contact:        Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
>  Description:
>                 Provides access to the binary "24x7 catalog" provided by the
>                 hypervisor on POWER7 and 8 systems. This catalog lists events
> -               avaliable from the powerpc "hv_24x7" pmu. Its format is
> +               available from the powerpc "hv_24x7" pmu. Its format is
>                 documented here:
>                 https://raw.githubusercontent.com/jmesmon/catalog-24x7/master/hv-24x7-catalog.h
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-tegra-fuse b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
> index 69f5af6..b8936fa 100644
> --- a/Documentation/ABI/testing/sysfs-driver-tegra-fuse
> +++ b/Documentation/ABI/testing/sysfs-driver-tegra-fuse
> @@ -3,7 +3,7 @@ Date:           February 2014
>  Contact:       Peter De Schrijver <pdeschrijver@nvidia.com>
>  Description:   read-only access to the efuses on Tegra20, Tegra30, Tegra114
>                 and Tegra124 SoC's from NVIDIA. The efuses contain write once
> -               data programmed at the factory. The data is layed out in 32bit
> +               data programmed at the factory. The data is laid out in 32bit
>                 words in LSB first format. Each bit represents a single value
>                 as decoded from the fuse registers. Bits order/assignment
>                 exactly matches the HW registers, including any unused bits.
> diff --git a/Documentation/ABI/testing/sysfs-fs-xfs b/Documentation/ABI/testing/sysfs-fs-xfs
> index ea0cc8c..f704925 100644
> --- a/Documentation/ABI/testing/sysfs-fs-xfs
> +++ b/Documentation/ABI/testing/sysfs-fs-xfs
> @@ -33,7 +33,7 @@ Contact:      xfs at oss.sgi.com
>  Description:
>                 The current state of the log write grant head. It
>                 represents the total log reservation of all currently
> -               oustanding transactions, including regrants due to
> +               outstanding transactions, including regrants due to
>                 rolling transactions. The grant head is exported in
>                 "cycle:bytes" format.
>  Users:         xfstests
> --
> 2.8.0
>
