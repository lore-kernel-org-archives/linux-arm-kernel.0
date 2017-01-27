From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 27 Jan 2017 16:27:25 +0100
Subject: [PATCH 2/4] mmc: bcm2835: Add new driver for the internal SD
 controller.
In-Reply-To: <1485516989-1072-3-git-send-email-kraxel@redhat.com>
References: <1485516989-1072-1-git-send-email-kraxel@redhat.com>
 <1485516989-1072-3-git-send-email-kraxel@redhat.com>
Message-ID: <CAPDyKFoWyZaRLhuBnFfJupxRnUvq-JWczS7ObjAGat056MCEyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 January 2017 at 12:36, Gerd Hoffmann <kraxel@redhat.com> wrote:
> From: Eric Anholt <eric@anholt.net>
>
> The 2835 has two SD controllers:  The Arasan SDHCI controller (supported
> by the iproc driver) and a custom SD controller.  This patch adds a
> driver for the custom SD controller.
>
> The custom controller runs faster, and driving the sdcard with the
> custom controller also allows to drive the rpi3 wifi with the iproc
> driver.
>

I don't understand this relationship. Is this somewhat configurable in runtime?

Is the WIFI module a removable SDIO card? So you can decide which
controller that is best suited to use? No?

Kind regards
Uffe
