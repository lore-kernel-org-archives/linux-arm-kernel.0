From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 27 Sep 2014 12:37:33 +0200
Subject: [PATCH] bcma: use device from DT (brcm,
 bus-gpio) for SoC GPIO chip
In-Reply-To: <54267661.5000401@hauke-m.de>
References: <1411741733-13888-1-git-send-email-zajec5@gmail.com>
 <2539898.4te2VKk57a@wuerfel>
 <CACna6rwwfJOdnxhmnW7MUuUC1YBPx8bmDbiaSy1+G39hF4p7OA@mail.gmail.com>
 <54267661.5000401@hauke-m.de>
Message-ID: <CACna6rwYcSh7-uFYA+paNehNwrqddmn2az+a9ZwggVGofbDR7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 September 2014 10:33, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> I would make GPIO a subdevive of chipcommon. The chipcommon core has an
> own IRQ which is also used for GPIO.

Which ChipCommon do yo mean?
1) chipcommonA (compatible = "simple-bus")
2) chipcommon at 0 (child of axi at 18000000 AKA brcm,bus-axi)

It seems that for some reason both of them use IRQ 85, while the IRQ
for ChipCommon is 117 I believe.

-- 
Rafa?
