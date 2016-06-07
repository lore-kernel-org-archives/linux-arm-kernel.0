From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 07 Jun 2016 08:03:55 +0200
Subject: [PATCH v3 00/12] usb/mmc/power: Generic power sequence (and fix
 USB/LAN when TFTP booting)
In-Reply-To: <2034186.JKeBi87zYl@diego>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
 <2034186.JKeBi87zYl@diego>
Message-ID: <575663CB.3070600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2016 10:43 PM, Heiko St?bner wrote:
> Hi,
> 
> Am Mittwoch, 1. Juni 2016, 10:02:09 schrieb Krzysztof Kozlowski:
>> My third approach for a USB power sequence which fixes usb3503+lan
>> on Odroid U3 board if it was initialized by bootloader
>> (e.g. for TFTP boot).
> 
> I was just tackling a similar bringup problem regarding an embedded usb hub 
> and usb-sata bridge and stumbled upon this series.
> 
> While on my (rockchip-)boards it's always "just" a reset pin that needs 
> handling, this series looks like it would solve exactly that problem in a very 
> nice way.
> 
> So while I cannot provide any meaningful insight right now, it would be cool 
> if you could keep me in the loop, as I'm really looking forward to this series 
> progressing.
> 

Sure, good to know that this problem affects more people. I do not feel
such alone anymore. ;)

Best regards,
Krzysztof
