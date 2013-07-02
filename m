From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Jul 2013 13:04:42 -0300
Subject: [PATCHv2 2/3] ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
In-Reply-To: <489238046.567779.1372774157223.open-xchange@email.1und1.de>
References: <1371754675-12242-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1371754675-12242-3-git-send-email-alexandre.belloni@free-electrons.com>
 <1235070882.565234.1372771759233.open-xchange@email.1und1.de>
 <CAOMZO5AASS4sr08i4K-uSUuvG+x9cjfFUtheY9JatA4dWCB0ww@mail.gmail.com>
 <489238046.567779.1372774157223.open-xchange@email.1und1.de>
Message-ID: <CAOMZO5CN614eF_YDEc92x4QY1JLc7b-BzZf-GbWFveNJE1oguw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 2, 2013 at 11:09 AM, Christoph G. Baumann <cb@sgoc.de> wrote:
> Hi Fabio,
>
>>
>> Differently than mx23, the mx28 reference manual states that ACK_MODE
>> bit has a default value of 1.
>>
>> Thanks for pointing this out, as we need to take this into
>> consideration for supporting mx23 in the mxs i2c driver.
>>
>
> nevertheless the mx28 I2C controller seems to suffer from this error too, as
> SMbus doesn't work with it.

Understood. Just sent a patch for this. Please help testing it.

Thanks,

Fabio Estevam
