From: jgarzik@pobox.com (Jeff Garzik)
Date: Sat, 11 Dec 2010 17:10:11 -0500
Subject: [PATCH v2] ata: pata_at91.c bugfix for high master clock
In-Reply-To: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
References: <1292099846-24528-1-git-send-email-plyatov@gmail.com>
Message-ID: <4D03F6C3.5030709@pobox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2010 03:37 PM, Igor Plyatov wrote:
> The AT91SAM9 microcontrollers with master clock higher then 105 MHz
> and PIO0, have overflow of the NCS_RD_PULSE value in the MSB. This
> lead to "NCS_RD_PULSE" pulse longer then "NRD_CYCLE" pulse and driver
> does not detect ATA device.
>
> Signed-off-by: Igor Plyatov<plyatov@gmail.com>

Thanks, queued (absent further comments...)
