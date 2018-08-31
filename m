From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 31 Aug 2018 15:47:42 +0300
Subject: [PATCHv2 0/4] ARM build infra changes to support building .dtbos
Message-ID: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This v2 is just a split of the v1 series, adding support for building
DT overlays to ARM build infra. The series also adds support for
individual Makefiles under boot/dts hierarchy, so that per-dir
flags or rules can be introduced (patch #2, #4.)

Depends on the kbuild change for adding support for building .dtbo files [1].

[1] https://marc.info/?l=linux-arm-kernel&m=153571933518229&w=2

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
