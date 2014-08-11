From: grant.b.edwards@gmail.com (Grant Edwards)
Date: Mon, 11 Aug 2014 20:43:35 +0000 (UTC)
Subject: Building kernel for more than one SoC
References: <lrdi48$ls1$1@ger.gmane.org>
 <20140804201712.GK30282@n2100.arm.linux.org.uk>
 <53E8E469.9050807@atmel.com> <lsaoih$e9$1@ger.gmane.org>
 <CAOCHtYgPoxveSjYpWWo8W+_0WwQdaCBga0piazg_Oq6aeZ=w-g@mail.gmail.com>
Message-ID: <lsb9tn$nnv$1@ger.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-08-11, Robert Nelson <robertcnelson@gmail.com> wrote:
>> Now it's up to somebody else to decide if the price difference between
>> a G20 and G25 is worth the engineering time to upgrade U-Boot and
>> Linux kernel to versions that know about device trees...
>
> http://cateee.net/lkddb/web-lkddb/ARM_APPENDED_DTB.html

Interesting.  That would still require modifying U-Boot so that at
run-time it detects the SoC type and appends the proper DTB to the
kernel image, but it that may be less work than "real" DTB support in
U-Boot.

-- 
Grant Edwards               grant.b.edwards        Yow! Now KEN and BARBIE
                                  at               are PERMANENTLY ADDICTED to
                              gmail.com            MIND-ALTERING DRUGS ...
