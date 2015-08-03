From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 03 Aug 2015 12:16:27 +0300
Subject: [PATCH v2 14/15] KVM: arm64: implement MSI injection in ITS
 emulation
In-Reply-To: <55BF2F51.6020701@linaro.org>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-15-git-send-email-andre.przywara@arm.com>
 <55BB7678.5080105@linaro.org> <55BE7BA1.40403@arm.com>
 <00a201d0cdb7$70a623f0$51f26bd0$@samsung.com> <55BF2F51.6020701@linaro.org>
Message-ID: <00f101d0cdcd$146a6090$3d3f21b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Again the case that leaves me uncomfortable is the one where the
> userspace does not provide the devid whereas it must (GICv3 ITS case).

 Hypothetical broken userland which does not exist for now ?
 IMHO the userland should just know, that if it supports ITS, it has to provide devIDs.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
