From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2012 20:45:17 -0800
Subject: [PATCH] ARM: bcmring: remove unused DMA map code
In-Reply-To: <8628FE4E7912BF47A96AE7DD7BAC0AAD0109D3D12CE3@SJEXCHCCR02.corp.ad.broadcom.com>
References: <8628FE4E7912BF47A96AE7DD7BAC0AAD0109D3D12CE3@SJEXCHCCR02.corp.ad.broadcom.com>
Message-ID: <CAOesGMhhh2bsC+sAZyyBOZw8Lgk1sR7e=ZB+RcnNJG-qDqiwtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 24, 2012 at 1:18 PM, JD (Jiandong) Zheng
<jdzheng@broadcom.com> wrote:
> Remove BCMRING DMA map code which is no longer used.
>
> This also fixes a build error with dma.c introduced by
> 6a40b33270564d706396f1b514a988d3c.

What is this patch based on? It doesn't apply on top of 3.3-rc1, nor
v3.2, 3.1, 3.0 or current linux-next.

Also, that SHA doesn't exist in the mainline tree, nor in linux-next.

Please make sure that patches you submit as a maintainer apply cleanly
on top of the tree you want them included in.


Thanks,

-Olof
