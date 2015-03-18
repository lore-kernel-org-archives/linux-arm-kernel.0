From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Wed, 18 Mar 2015 10:31:42 +0100
Subject: [PATCH v12 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
In-Reply-To: <54E3A3CD.3020106@gmx.net>
References: <1416576682-5255-1-git-send-email-thomas.ab@samsung.com>
 <CAMAWPa9fUJVjJ8V+93AkHy9DtEmUUnGs4MJDGcsoMdWwGmg5qg@mail.gmail.com>
 <CAJKOXPfyPH7tyce6YB=q4krSP078aJVAmqObg89qCnLrL_Nbhg@mail.gmail.com>
 <20150216105217.79315ffd@amdc2363> <54E3A3CD.3020106@gmx.net>
Message-ID: <CABxcv=nRZiMy3_ynSV81TDTKKCNFXrF6Er7-xU9MavwMaJ=9jA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On Tue, Feb 17, 2015 at 9:25 PM, Tobias Jakobi <liquid.acid@gmx.net> wrote:
> Hello!
>
> Lukasz Majewski wrote:
>> Hi Krzysztof, Thomas,
>>
>>> 2015-01-08 22:17 GMT+01:00 Kevin Hilman <khilman@kernel.org>:
>>> Hi Thomas,
>>>
>>> Do you plan to continue with this work? It would be very helpful.
>>
>> +1 from me.
>>
>>>
>>> I also wonder if Exynos 4412 could be re-added (without the boost if
>>> these bindings are not ready)?
>>
>> I would prefer to have all platforms converted at once, since it might
>> happen that some parts of the work would get lost.
>
> Joining in as well!
>
> Reviving this patch series would be very much appreciated, especially if
> it moves again into the direction of storing most information into the
> DT (so that one can easily modify it in the board dts).
>
> With best wishes,
> Tobias
>

As others stated, it would be very useful to get this patch-set in but
the current version has some issues as Kevin mentioned.

Are you planning to continue working on this series?

Best regards,
Javier
