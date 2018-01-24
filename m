From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 12:13:42 +0100
Subject: [PATCH v3 00/22] Verbatim device names and
 devm_nvmem_(un)register()
In-Reply-To: <20180103200114.23922-1-andrew.smirnov@gmail.com>
References: <20180103200114.23922-1-andrew.smirnov@gmail.com>
Message-ID: <CAMRc=Mct60LMcr-CGJue1dTK+XNwz=dmkm2arTGeN1czeN9JoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-03 21:00 GMT+01:00 Andrey Smirnov <andrew.smirnov@gmail.com>:
> Srinivas, all:
>
> This patchset contains various small changes that I recently made to
> NVMEM, more specifically:
>
>  - Patches 1 and 3 are two changes I am hoping are acceptable upstream
>
>  - Patches 4 to 15 are a follow up to patch 2
>
>  - Patches 16 to 22 are just trivial fixups and I am more than happy
>    to drop them if they seem to add more pointless churn rather then
>    value.
>
> Feedback is appreciated!
>
> Thanks,
> Andrey Smirnov
>
> Changes since [v2]:
>
>  - Added a patch with kerenl doc for struct nvmem_config as a
>    prerequsite for patch #2
>
>  - Documented behaviour of nvmem_register() when id is set to -1
>
>  - Added kernel doc for devm_nvmem_(un)register()
>
>
> Changes since [v1]:
>
>  - Fixed a build break detected by kbuild test robot
>
>  - Added a patch to unconditionally enable COMPILE_TEST for meson-efuse
>
>  - Dropped Joachim Eastwood from CC list due to bouncing e-mail
>
> [v2] lkml.kernel.org/r/20180101232310.30420-1-andrew.smirnov at gmail.com
> [v1] lkml.kernel.org/r/20171227225956.14442-1-andrew.smirnov at gmail.com
>
>

Hi Srinivas,

I don't see this series in next - is it going to miss this merge window?

Thanks,
Bartosz
