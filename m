From: martin@strongswan.org (Martin Willi)
Date: Thu, 08 Nov 2018 07:47:23 +0100
Subject: [RFC PATCH v3 00/15] crypto: Adiantum support
In-Reply-To: <20181105232526.173947-1-ebiggers@kernel.org>
References: <20181105232526.173947-1-ebiggers@kernel.org>
Message-ID: <757b2f06657d68929ce14d2bac3eb111bb06e6ab.camel@strongswan.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

> This patchset adds Adiantum to Linux's crypto API, focusing on
> generic and ARM32 implementations.  Patches 1-9 add support for
> XChaCha20 and XChaCha12.  Patches 10-13 add NHPoly1305 support,
> needed for Adiantum hashing. Patch 14 adds Adiantum support as a
> skcipher template.

Nice work. I did a quick review only, but you may add my

  Acked-by: Martin Willi <martin@strongswan.org>

for patches 1-5, 10 and 11.

Thanks,
Martin
