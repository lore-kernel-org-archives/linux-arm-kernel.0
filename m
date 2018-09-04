From: t-kristo@ti.com (Tero Kristo)
Date: Tue, 4 Sep 2018 11:27:29 +0300
Subject: [RESEND PATCHv2 0/2] ARM: dts: TI: add support for TI SoC overlays
In-Reply-To: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
References: <1535722107-13767-1-git-send-email-t-kristo@ti.com>
Message-ID: <1536049651-10206-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is the final piece of the code to get build support for
Texas Instruments SoC DT overlays in place. Basically we just modify
the makefiles to add DTC_FLAGS for symbols, which are needed to actually
apply the overlays properly. This series depends on [1].

v2 of the series is just a split of the v1 which had the whole support
included in one series.

Resending as I missed Frank from delivery of the initial v2.

-Tero

[1] https://marc.info/?l=linux-arm-kernel&m=153604844620162&w=2

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
