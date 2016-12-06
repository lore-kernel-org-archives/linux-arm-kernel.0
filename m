From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 6 Dec 2016 10:59:18 +0530
Subject: ILP32 for ARM64: testing with glibc testsuite
In-Reply-To: <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <20161107082359.GA19666@yury-N73SV>
 <20161109095650.GA22804@yury-N73SV>
 <CC4F99A7-1FD2-486A-BD66-ED06F1B8BF50@linaro.org>
 <1479419136.908.90.camel@caviumnetworks.com>
 <ff3b973b-3887-7ae8-5a27-4d1ad115055f@huawei.com>
 <mvmeg1mn0yp.fsf@hawking.suse.de>
 <d4dedc32-b324-107d-7de1-d1e670ffc00a@huawei.com>
Message-ID: <20161206052918.GA12474@yury-N73SV>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 06:24:11PM +0800, Zhangjian (Bamvor) wrote:
> 
> 
> On 2016/12/5 18:07, Andreas Schwab wrote:
> >On Dez 05 2016, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com> wrote:
> >
> >>Is there some progresses on it? We could collabrate to fix those issues.
> >
> >All the elf/nptl/rt fails should be fixed by the recent binutils fixes.
> Cool. How about the conform and other failures?

I think conform is only my local problem. I use pretty non-standard
environment for build and testing - cross-compilation + qemu. Steve
builds and runs tests natively, and he doesn't see that regressions.

Yury
