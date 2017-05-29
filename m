From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Mon, 29 May 2017 08:44:06 +0530
Subject: [RESEND PATCH 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
In-Reply-To: <1495004445-2043-1-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1495004445-2043-1-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <CAFpQJXVxJiiY-BgBO24+PY1qmW6PK0zDUzyanAa3XTnFSxYrsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, Will,

can you please review this patchset?

On Wed, May 17, 2017 at 12:30 PM, Ganapatrao Kulkarni
<ganapatrao.kulkarni@cavium.com> wrote:
> This adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
> The SoC has PMU support in its L3 cache controller (L3C) and in the
> DDR4 Memory Controller (DMC).
>
> Ganapatrao Kulkarni (2):
>   perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
>   perf: ThunderX2: Add Cavium Thunderx2 SoC UNCORE PMU driver
>
>  Documentation/perf/thunderx2-pmu.txt |  60 +++
>  drivers/perf/Kconfig                 |   9 +
>  drivers/perf/Makefile                |   1 +
>  drivers/perf/thunderx2_pmu.c         | 965 +++++++++++++++++++++++++++++++++++
>  4 files changed, 1035 insertions(+)
>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>  create mode 100644 drivers/perf/thunderx2_pmu.c
>
> --
> 1.8.1.4
>

thanks
Ganapat
