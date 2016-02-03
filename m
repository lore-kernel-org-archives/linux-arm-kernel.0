From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 3 Feb 2016 13:17:15 +0100
Subject: [PATCH v4] mmc: meson: Add driver for the SD/MMC host found on
 Amlogic MesonX SoCs
In-Reply-To: <1448988109-32630-1-git-send-email-carlo@caione.org>
References: <1448988109-32630-1-git-send-email-carlo@caione.org>
Message-ID: <56B1EFCB.1020508@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Carlo,

Am 01.12.2015 um 17:41 schrieb Carlo Caione:
> From: Carlo Caione <carlo@endlessm.com>
>
> Add a driver for the SD/MMC host found on the Amlogic MesonX SoCs. This
> is an MMC controller which provides an interface between the application
> processor and various memory cards. It supports the SD specification
> v2.0 and the eMMC specification v4.41.
>
> This patch adds also the binding documentation.

according to Documentation/devicetree/bindings/submitting-patches.txt

the binding should be a separate patch in a series.

Stefan
