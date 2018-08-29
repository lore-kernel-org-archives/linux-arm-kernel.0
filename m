From: Jason@zx2c4.com (Jason A. Donenfeld)
Date: Tue, 28 Aug 2018 23:06:42 -0600
Subject: [PATCH v2 15/17] zinc: Curve25519 ARM implementation
In-Reply-To: <CAKv+Gu-WVOBZ1sQwOKo29P_jWL86wOnzd1-sB_6mTbPX1Lz0NQ@mail.gmail.com>
References: <20180824213849.23647-1-Jason@zx2c4.com>
 <20180824213849.23647-16-Jason@zx2c4.com>
 <CAKv+Gu-WVOBZ1sQwOKo29P_jWL86wOnzd1-sB_6mTbPX1Lz0NQ@mail.gmail.com>
Message-ID: <CAHmME9rs+8kynZym=E4btqOu+Sh7MFn3kq7EPDXP27WzC9j_ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Ard,

Thanks for the thorough review. Very much appreciated. I've
incorporated nearly all of your suggestions into my development tree:

https://git.kernel.org/pub/scm/linux/kernel/git/zx2c4/linux.git/tree/lib/zinc/curve25519/curve25519-arm.S?h=jd/wireguard

These changes will be part of v3.

Regards,
Jason
