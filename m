From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 19 Mar 2015 16:09:34 -0600
Subject: [PATCH 0/5] coresight: next
In-Reply-To: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
References: <1425078294-13059-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <CANLsYkz=f_DyQq9jkk3CmHzqUCQABO1cSwRzwCbwh5U34b96yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 February 2015 at 16:04, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> These are the latest coresight patches that I'd like you to consider for
> inclusion in your tree.  The set is based on v4.0-rc1.
>
> Thanks,
> Mathieu
>
> Mathieu Poirier (4):
>   coresight: making cpu index lookup arm64 compliant
>   coresight: fixing compilation warnings picked up by 64bit compiler
>   coresight: Adding coresight support for arm64 architecture
>   coresight-stm: Bindings for System Trace Macrocell
>
> Pratik Patel (1):
>   coresight-stm: adding driver for CoreSight STM component
>
>  .../ABI/testing/sysfs-bus-coresight-devices-stm    |   62 ++
>  .../devicetree/bindings/arm/coresight.txt          |   28 +
>  Documentation/trace/coresight.txt                  |   88 +-
>  arch/arm/Kconfig.debug                             |   55 +-
>  arch/arm64/Kconfig.debug                           |    2 +
>  drivers/coresight/Kconfig                          |   71 ++
>  drivers/coresight/Makefile                         |    1 +
>  drivers/coresight/coresight-etb10.c                |    4 +-
>  drivers/coresight/coresight-stm.c                  | 1070 ++++++++++++++++++++
>  drivers/coresight/coresight-tmc.c                  |    4 +-
>  drivers/coresight/of_coresight.c                   |   18 +-
>  include/linux/coresight-stm.h                      |   40 +
>  include/uapi/linux/coresight-stm.h                 |   23 +
>  13 files changed, 1394 insertions(+), 72 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
>  create mode 100644 drivers/coresight/Kconfig
>  create mode 100644 drivers/coresight/coresight-stm.c
>  create mode 100644 include/linux/coresight-stm.h
>  create mode 100644 include/uapi/linux/coresight-stm.h
>
> --
> 1.9.1
>

Greg,

I haven't received the usual notifications telling me that you have
added these patches to your tree.  As such I would ask you to
disregard this submission entirely as fair amount of things have
changed since the time it was sent out.  I will send you another set
that has the latest and accurate modifications.

I can also send you a patchset that applies on top of this one and
that brings everything up to date - whichever is the easiest for you.

Best regards,
Mathieu
