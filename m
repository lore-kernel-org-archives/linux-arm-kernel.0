From: ynorov@caviumnetworks.com (Yury Norov)
Date: Thu, 16 Nov 2017 14:11:30 +0300
Subject: [PATCH v8 00/20] ILP32 for ARM64
In-Reply-To: <20170619155003.13218-1-ynorov@caviumnetworks.com>
References: <20170619155003.13218-1-ynorov@caviumnetworks.com>
Message-ID: <20171116111130.f5xmomxgm234i6v7@yury-thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Arnd, all,

This is ILP32 patches on top of 4.14 kernel:
https://github.com/norov/linux/commits/ilp32-4.14

I tested the series with LTP lite built by Linaro toolchain, and no
regressions found.

By the way, do you have plans to upstream arch subseries? 
https://lkml.org/lkml/2017/9/25/574

Yury
