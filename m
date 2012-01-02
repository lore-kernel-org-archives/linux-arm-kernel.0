From: pullip.cho@samsung.com (KyongHo Cho)
Date: Tue, 3 Jan 2012 00:21:30 +0900
Subject: [PATCH v8 0/2] ommu/exynos: Add IOMMU/System MMU driver for
 Samsung Exynos
In-Reply-To: <20120102134229.GZ29877@amd.com>
References: <000e01ccc624$c9349310$5b9db930$%cho@samsung.com>
 <20120102134229.GZ29877@amd.com>
Message-ID: <CAHQjnON3XYZ9cAK0kqsY4QzMzESD1wOzxt-fiQCq3TJfDObFiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi
On Mon, Jan 2, 2012 at 10:42 PM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> Hi,
>
> On Thu, Dec 29, 2011 at 09:24:18PM +0900, KyongHo Cho wrote:
>> Changes since v7:
>> - Rebased with the recent commits of the following git branches
>> ? * git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/next
>> ? * git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git/for-next
>> - Changed magic numbers into macros
>> - Setting owner of a System MMU in 'iommu' field of dev_archdata
>> - Verbose message in the default fault handler
>> - Some bug fixes.
>
> I still get
>
> ?LD ? ? ?.tmp_vmlinux1
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> /data/cross/gcc-4.6.0-nolibc/arm-unknown-linux-gnueabi/bin/arm-unknown-linux-gnueabi-ld: no machine record defined
> make[1]: *** [.tmp_vmlinux1] Error 1
>
> when trying to compile ARM/Exynos with 3.2-rc7. Am I doing something
> wrong or is this not expected to work?
>
Do you?
Ok. I will check my configuration with linux-next git.

Thank you.

KyongHo
