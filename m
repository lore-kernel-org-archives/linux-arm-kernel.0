From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 14 Sep 2012 12:28:32 +0530
Subject: [Query] Does u-boot processes dtb file
Message-ID: <CAKohpomkgk_hNAwqseAvc_cyLH+Vtr63r_hJGxsKueZhKno8_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


Sorry for the stupid question, but somebody asked this to me and i wasn't sure
about it.

We boot with dtb from u-boot using following command:
bootm <uImage addr> <initrd addr> <dtb addr>

Does u-boot do anything special or simply passes address of dtb in r2 to kernel?

i.e. if i do bootm <uImage addr> and stop my kernel early using a debugger,
update r2 with dtb address, will it work the same way?

OR

Does any bootloader needs some special code for handling dtb's?

--
viresh
