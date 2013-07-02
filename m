From: cb@sgoc.de (Christoph G. Baumann)
Date: Tue, 2 Jul 2013 16:09:17 +0200 (CEST)
Subject: [PATCHv2 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <CAOMZO5AASS4sr08i4K-uSUuvG+x9cjfFUtheY9JatA4dWCB0ww@mail.gmail.com>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
 <1235070882.565234.1372771759233.open-xchange@email.1und1.de>
 <CAOMZO5AASS4sr08i4K-uSUuvG+x9cjfFUtheY9JatA4dWCB0ww@mail.gmail.com>
Message-ID: <489238046.567779.1372774157223.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

>
> Differently than mx23, the mx28 reference manual states that ACK_MODE
> bit has a default value of 1.
>
> Thanks for pointing this out, as we need to take this into
> consideration for supporting mx23 in the mxs i2c driver.
>

nevertheless the mx28 I2C controller seems to suffer from this error too, as
SMbus doesn't work with it.



Regards
Christoph
