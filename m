From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 4 Sep 2018 11:05:40 +0300
Subject: [RESEND PATCHv2 0/4] ARM build infra changes to support building
 .dtbos
In-Reply-To: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
References: <1535719666-13595-1-git-send-email-t-kristo@ti.com>
Message-ID: <1536048344-9995-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This v2 is just a split of the v1 series, adding support for building
DT overlays to ARM build infra. The series also adds support for
individual Makefiles under boot/dts hierarchy, so that per-dir
flags or rules can be introduced (patch #2, #4.)

Resending due to missing Frank from delivery of initial v2.

Depends on the kbuild change for adding support for building .dtbo files [1].

[1] https://marc.info/?l=linux-arm-kernel&m=153604732319790&w=2

-Tero

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
