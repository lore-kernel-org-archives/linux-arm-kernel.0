From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 29 Dec 2016 16:55:56 -0200
Subject: [PATCH 4/6] ARM: mach-mx35_3ds: Remove camera support
In-Reply-To: <CAM=E1R64X6o0o604gGiU4+uQ6W_PUSbzgpaAYWSYEiSz_D8uGQ@mail.gmail.com>
References: <1482756987-12414-1-git-send-email-festevam@gmail.com>
 <1482756987-12414-4-git-send-email-festevam@gmail.com>
 <CAM=E1R64X6o0o604gGiU4+uQ6W_PUSbzgpaAYWSYEiSz_D8uGQ@mail.gmail.com>
Message-ID: <CAOMZO5CF8QiJ21VbJCs4nj-WiAnfhsU0v7XpLGM3rcN1GoPiMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 4:41 PM, Magnus Lilja <lilja.magnus@gmail.com> wrote:

> Umm, did you really mean to remove VAUDIO/vaudio_init stuff in this
> camera related patch?

VAUDIO is the MC13783 PMIC output name, but despite its name it has no
relationship with the audio circuitry on mx35pdk board.

It powers the OV2640 camera on this board, so it is safe to remove it.
