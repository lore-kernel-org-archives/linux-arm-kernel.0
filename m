From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Aug 2013 09:52:47 +0900
Subject: [RFC] cleanup mach-s5p*
Message-ID: <1f7b01cea1f6$9560aa10$c021fe30$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a plan to remove supporting following SoCs in mainline in the near
future.
- s5pc100 - smdkc100
- s5pv210(s5c110) - aquial, goni, smdkc110, smdkv210, torbreck
- s5p64x0(s5p6440, s5p6450)- smdk6440, smdk6450

I think users don't seem to use that any more with mainline. If so, we are
able to consider, it is not right now though.

How do you think?

- Kukjin
