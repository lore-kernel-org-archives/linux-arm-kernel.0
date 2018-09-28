From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Fri, 28 Sep 2018 18:04:39 +0200
Subject: [PATCH] arm: support big-endian for the virt architecture
In-Reply-To: <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
References: <20180926135110.13061-1-Jason@zx2c4.com>
 <CAK8P3a0+s6DM=QUqS_KrNp+95aDj2QTsWb+w73piwLsQFvq+pg@mail.gmail.com>
Message-ID: <CAHmME9o_6o_wB00kASJdqJyWt2wFH2FqdzXOm8RLA5VeCibDJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Sep 28, 2018 at 5:59 PM Arnd Bergmann <arnd@arndb.de> wrote:
> Applied for 4.20 with subject line changed s/arm/ARM/, thanks!

Thanks.

> I think most people just build a 'defconfig' kernel, which includes
> multiple platforms that use ARCH_SUPPORTS_BIG_ENDIAN.

Right, that's what it looked like. In my case, I'm doing CI on some
homebrewed infra, where I'm building lots of kernels for lots of
architectures and testing them in qemu with various tests _for each
and every commit_. Not having a server farm as impressive as Intel's
0-day infra, getting compilation times down is rather important.

> Your patch is certainly fine for 4.20, but since we haven't decided
> what the proper fix should be, I didn't want to push this for 4.19.

Shucks. It's not like this patch makes the situation worse; it makes
it better. But I understand and will wait for 4.20/5.0.

Jason
