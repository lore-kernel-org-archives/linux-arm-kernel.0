From: roy.franz@linaro.org (Roy Franz)
Date: Mon, 3 Mar 2014 23:48:39 -0800
Subject: [PATCH 06/22] Add helper functions used by arm/arm64
In-Reply-To: <20140303140811.GA18828@console-pimps.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-7-git-send-email-leif.lindholm@linaro.org>
 <20140213112606.GF20717@console-pimps.org>
 <CAFECyb_wUphr4XOyW9tC-Rw5Py3m39e6GQorCtFGtSXTUTBnFQ@mail.gmail.com>
 <20140303140811.GA18828@console-pimps.org>
Message-ID: <CAFECyb9eXYCFTQ7G35EEsx0P2vRwm7qNtwT46ZteTGbycbcEBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 6:08 AM, Matt Fleming <matt@console-pimps.org> wrote:
> On Fri, 14 Feb, at 11:02:49AM, Roy Franz wrote:
>>
>> The get_dram_base() function is only used by arm/arm64, but
>> there is nothing architecture specific about it, which is why I put it
>> here to begin with.  I don't feel strongly about this either way.
>
> Sorry Roy, I just realised that you probably wanted a response from me
> about this last point.
>
> OK, leaving get_dram_base() in efi-stub-helper.c is fine.
>
> FYI, "NUL" isn't a typo,
>
>> -     options_size++;  /* NUL termination */
> [...]
>> +     options_size++;  /* NULL termination */
>
> http://en.wikipedia.org/wiki/Null_character
>
> --
> Matt Fleming, Intel Open Source Technology Center

Thanks - I'll take care of this in the next revision.

Roy
