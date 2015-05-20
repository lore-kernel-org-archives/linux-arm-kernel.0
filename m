From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 20 May 2015 09:35:36 +0900
Subject: linux-next: manual merge of the samsung tree with the arm-soc and
 at91 trees
In-Reply-To: <20150520102743.3d336a73@canb.auug.org.au>
References: <20150520102743.3d336a73@canb.auug.org.au>
Message-ID: <CAJKOXPdsi-5kdQJtybeaMCy0DXuRTRGgBEOM=SH9BsjquEMjCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-05-20 9:27 GMT+09:00 Stephen Rothwell <sfr@canb.auug.org.au>:
> Hi Kukjin,
>
> Today's linux-next merge of the samsung tree got a conflict in
> arch/arm/configs/multi_v7_defconfig between various commits from the
> arm-soc and at91 trees and various commits from the samsung tree.
>
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Hi,

Thanks for the merge.

The parts coming from samsung-soc related to manually toggling stuff
(by me and Javier) look fine. The rest (coming from Kukjin's
savedefconfig) I don't know - too much of them.

On the other hand I wonder if savedefconfig was done on 4.1-rc1 (base
of branch samsung-defconfig [0]). If yes then it would discard any
Kconfig changes (like new dependencies and symbols) done in for-next
of arm-soc tree.

[0] https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=samsung-defconfig

Best regards,
Krzysztof
