From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Thu, 27 Feb 2014 17:09:20 +0530
Subject: ARM64: Not all h/w events are mapped in perf_event.c
Message-ID: <CAFpQJXXD1f=PvUTtRKaRRK-ADU=HaUr2QmTG=by3vP=2eYhAkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

All h/w perf events are not mapped in arch/arm64/kernel/perf_event.c
(many are set to HW_OP_UNSUPPORTED/CACHE_OP_UNSUPPORTED)

any specific reason for not mapping?


thanks
Ganapat
