From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 29 Dec 2015 10:01:04 -0800
Subject: [PATCH 02/10] spi: cadence, zynq: use to_platform_device()
In-Reply-To: <522ef92bb1d83c651cbdd12ff10b594b2e2a691c.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
 <522ef92bb1d83c651cbdd12ff10b594b2e2a691c.1451221174.git.geliangtang@163.com>
Message-ID: <CAAtXAHd_Xp4WbXMSY5QVLT7cYnpbzObf5UHCnuzh64LgOBER3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Dec 27, 2015 at 5:15 AM, Geliang Tang <geliangtang@163.com> wrote:
> Use to_platform_device() instead of open-coding it.
>
Reviewed-by: Moritz Fischer <moritz.fischer@ettus.com>
> Signed-off-by: Geliang Tang <geliangtang@163.com>

Looks good to me, maybe (nit) split it up into two commits.

Cheers,

Moritz
