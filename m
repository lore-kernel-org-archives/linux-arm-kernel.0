From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Nov 2018 23:51:12 +0800
Subject: [PATCH 03/15] ARM: dts: sun8i-h3: Fix the system-control register
 range
In-Reply-To: <20181115145013.3378-4-paul.kocialkowski@bootlin.com>
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com>
 <20181115145013.3378-4-paul.kocialkowski@bootlin.com>
Message-ID: <CAGb2v66jEqqYA8-96GzguE_=PZribEDaMXxrYupTQdwjPkmBRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Unlike in previous generations, the system-control register range is not
> limited to a size of 0x30 on the H3. In particular, the EMAC clock
> configuration register (accessed through syscon) is at offset 0x30 in
> that range.
>
> Extend the register size to its full range (0x1000) as a result.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Other than the subject format,

Acked-by: Chen-Yu Tsai <wens@csie.org>
