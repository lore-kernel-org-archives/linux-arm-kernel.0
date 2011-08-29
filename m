From: B04825@freescale.com (Tabi Timur-B04825)
Date: Mon, 29 Aug 2011 20:34:56 +0000
Subject: [alsa-devel] [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
	checking for each DAIs separately
In-Reply-To: <1314609314-22162-1-git-send-email-b29396@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
Message-ID: <CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 4:15 AM, Dong Aisheng <b29396@freescale.com> wrote:
> The orginal code does not cover the case that one DAI such as codec
> may be shared between other two DAIs(CPU).

Can you give me an example of how this can occur?

-- 
Timur Tabi
Linux kernel developer at Freescale
