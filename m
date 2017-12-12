From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Tue, 12 Dec 2017 10:14:56 +0100
Subject: [PATCH net-next v5 2/2] net: ethernet: socionext: add AVE
 ethernet driver
In-Reply-To: <CAA93ih0C-aMpFAhU+5x6P=QjiOVRPZ0UL1wyKh1oeXzC8UjPXQ@mail.gmail.com>
References: <1512979049-15930-3-git-send-email-hayashi.kunihiko@socionext.com>
 <CAOFm3uELNTgenR91-QGL1QQ08zA0N0rQbH4hzCzFKtRw6TckLw@mail.gmail.com>
 <20171211210455.170A.4A936039@socionext.com>
 <CAA93ih2i+G2uyL8O-4F1juR1DpUYCd1U1dBCRRM5Xdd3L-m95g@mail.gmail.com>
 <20171211134627.GU10595@n2100.armlinux.org.uk>
 <CAA93ih0C-aMpFAhU+5x6P=QjiOVRPZ0UL1wyKh1oeXzC8UjPXQ@mail.gmail.com>
Message-ID: <CAOFm3uF65yY3zEfTzM888z2Se24uHyoWi8iy9eBn-x_SP8=kwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Masami-san,

On Tue, Dec 12, 2017 at 3:29 AM, Masami Hiramatsu
<masami.hiramatsu@linaro.org> wrote:
[...]
> Then what I'm considering is copyright notice lines. Those are usually
> treat as the header lines, not single line. So
>
>> +// SDPX-License-Identifier: GPL-2.0
>> +// sni_ave.c - Socionext UniPhier AVE ethernet driver
>> +// Copyright 2014 Panasonic Corporation
>> +// Copyright 2015-2017 Socionext Inc.
>
> is acceptable? or should we keep C-style header lines for new drivers?
>
>> +// SDPX-License-Identifier: GPL-2.0
>> +/*
>> + * sni_ave.c - Socionext UniPhier AVE ethernet driver
>> + * Copyright 2014 Panasonic Corporation
>> + * Copyright 2015-2017 Socionext Inc.
>> + */
>
> I just concern that those lines are not "single". that's all. :)

My voice carries the weight of a down feather in this discussion and
to me the benefit of the first form is that you have removed two
lines. Both forms work fine.

-- 
Cordially
Philippe Ombredanne
