From: bjorn@kryo.se (Bjorn Andersson)
Date: Tue, 11 Mar 2014 22:18:29 -0700
Subject: Qualcomm PMIC8XXX keypad never worked?
In-Reply-To: <20140311130609.GL21216@lee--X1>
References: <5887114.1jrNo21sGX@wuerfel> <20140311120056.GH21216@lee--X1>
 <8206209.oc1V5pPVYT@wuerfel> <20140311130609.GL21216@lee--X1>
Message-ID: <CAJAp7OgF235DNLC9aaxh15SPwVir9QBjgfi_C1gvmX-o3bHZ9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 6:06 AM, Lee Jones <lee.jones@linaro.org> wrote:
[snip]
>
> ... but the MFD isn't broken, so I guess your solution is the most
> elegant. If it's not fixed soon, I guess we should think about ripping
> it out. It's obvoious that no-one cares, as it's been broken for
> nearly 3 years.

Stephen Boyd have a series out on these drivers; fixing this, turning
them DT and some other goodies.

The related part for this would be:
https://patchwork.kernel.org/patch/3765191/

Unfortunately lkml.org seems down, so I can't link to the series.

Regards,
Bjorn
