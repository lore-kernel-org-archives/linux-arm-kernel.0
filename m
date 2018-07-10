From: gklkml16@gmail.com (Ganapatrao Kulkarni)
Date: Tue, 10 Jul 2018 17:26:38 +0530
Subject: [PATCH v6 0/2] Add ThunderX2 SoC Performance Monitoring Unit
 driver
In-Reply-To: <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com>
References: <20180621063338.20093-1-ganapatrao.kulkarni@cavium.com>
 <CAKTKpr5bNdo2oXb=Vsm4QytHN1Aw=n_oP7kJHV6yLHuKL-Udkg@mail.gmail.com>
Message-ID: <CAKTKpr7wMiJL3NCHp-BkqNFPTDPAB7BxTvbvJagwYY97JCwqHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 3:44 PM, Ganapatrao Kulkarni <gklkml16@gmail.com> wrote:
> Hi Mark,
>
> can you please review this patch?

any comments on this patch series?

>
> On Thu, Jun 21, 2018 at 12:03 PM, Ganapatrao Kulkarni
> <ganapatrao.kulkarni@cavium.com> wrote:
>> This patchset adds PMU driver for Cavium's ThunderX2 SoC UNCORE devices.
>> The SoC has PMU support in L3 cache controller (L3C) and in the
>> DDR4 Memory Controller (DMC).
>>
>> v6:
>>         Rebased to 4.18-rc1
>>         Updated with comments from John Garry[3]
>>
>> [3] https://lkml.org/lkml/2018/5/17/408
>>
>> v5:
>>      -Incroporated review comments from Mark Rutland[2]
>> v4:
>>      -Incroporated review comments from Mark Rutland[1]
>>
>> [1] https://www.spinics.net/lists/arm-kernel/msg588563.html
>> [2] https://lkml.org/lkml/2018/4/26/376
>>
>> v3:
>>      - fixed warning reported by kbuild robot
>>
>> v2:
>>      - rebased to 4.12-rc1
>>      - Removed Arch VULCAN dependency.
>>      - update SMC call parameters as per latest firmware.
>>
>> v1:
>>      -Initial patch
>>
>> Ganapatrao Kulkarni (2):
>>   perf: uncore: Adding documentation for ThunderX2 pmu uncore driver
>>   ThunderX2: Add Cavium ThunderX2 SoC UNCORE PMU driver
>>
>>  Documentation/perf/thunderx2-pmu.txt |  66 +++
>>  drivers/perf/Kconfig                 |   8 +
>>  drivers/perf/Makefile                |   1 +
>>  drivers/perf/thunderx2_pmu.c         | 949 +++++++++++++++++++++++++++++++++++
>>  include/linux/cpuhotplug.h           |   1 +
>>  5 files changed, 1025 insertions(+)
>>  create mode 100644 Documentation/perf/thunderx2-pmu.txt
>>  create mode 100644 drivers/perf/thunderx2_pmu.c
>>
>> --
>> 2.9.4
>>
>
> thanks
> Ganapat
