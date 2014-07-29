From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 21:07:40 -0700
Subject: [PATCH v15 09/12] ARM: config: append hip04_defconfig
In-Reply-To: <1406555876-11989-10-git-send-email-haojian.zhuang@linaro.org>
References: <1406555876-11989-1-git-send-email-haojian.zhuang@linaro.org>
 <1406555876-11989-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140729040740.GC8430@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 09:57:53PM +0800, Haojian Zhuang wrote:
> Select HiP04 SoC configuration by hip04_defconfig.

Your subject says "append hip04_defconfig", but this adds it.

Also, the one-sentence description doesn't quite make sense.

We normally keep one defconfig per vendors these days. For server platforms,
having per-vendor configs doesn't make sense in the same way as embedded
platforms, since enabling a few extra platforms and drivers isn't nearly as big
a deal with you have 12.5GB RAM.

So, please just enable your drivers in multi_v7 and don't add a
hip04_defconfig.


-Olof
