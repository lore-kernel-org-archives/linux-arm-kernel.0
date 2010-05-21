From: tbm@cyrius.com (Martin Michlmayr)
Date: Fri, 21 May 2010 19:56:06 +0100
Subject: [PATCH] qnap tsx1x: fix section mismatch
In-Reply-To: <87wrv9dtcr.fsf@lechat.rtp-net.org>
References: <87wrv9dtcr.fsf@lechat.rtp-net.org>
Message-ID: <20100521185606.GA1697@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnaud Patard <arnaud.patard@rtp-net.org> [2010-05-12 17:37]:
> Fix the following warning :
> WARNING: vmlinux.o(.text+0x95a0): Section mismatch in reference from the
> function qnap_tsx1x_register_flash() to the (unknown reference) .init.data:(unknown)
> The function qnap_tsx1x_register_flash() references
> the (unknown reference) __initdata (unknown).
> This is often because qnap_tsx1x_register_flash lacks a __initdata
> annotation or the annotation of (unknown) is wrong.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>

-- 
Martin Michlmayr
http://www.cyrius.com/
