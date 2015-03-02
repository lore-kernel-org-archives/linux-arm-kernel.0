From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 03 Mar 2015 04:04:08 +0900
Subject: [PATCH 00/10] ARM: s3c64xx multiplatform, help needed
In-Reply-To: <CA+Ln22HVJVN8kRdgAkhzJvuRKBYpPdk4NWmH3p+Q15wqpcgzFQ@mail.gmail.com>
References: <1425299763-4066822-1-git-send-email-arnd@arndb.de>
 <CA+Ln22HVJVN8kRdgAkhzJvuRKBYpPdk4NWmH3p+Q15wqpcgzFQ@mail.gmail.com>
Message-ID: <54F4B428.1020205@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 01:53, Tomasz Figa wrote:
> Hi Arnd,
> 
Hi,

> Thanks a lot for these patches.
> 
> 2015-03-02 21:35 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> Hi everyone,
>>
>> I've had these patches in a private git tree for a while, and have
>> finally gotten around to clean them up some more for submission.
>> Hopefully we can get all of it merged into 4.1.
>>
Sure,

>> I've done this to the best of my knowledge, but some parts are
>> a bit tricky, so I expect that there are bugs. The trickiest
>> part is the touchscreen driver. I've sent it out for review
>> last year already, but I have not found anybody who could test
>> it, and it's basically a blind rewrite of an existing driver,
>> so it's unlikely that I got it all right.
>>
>> The other parts may actually work, but it is possible that
>> I made a mistake with the ASoC driver, the sparseirq support
>> or something else.
>>
>> Does anyone still have access to the hardware? I'm particularly
>> interested in seeing this patch set get tested on smartq
>> and on smdk6410, which have the majority of the hardware.
> 
> I still have a tiny6410, which is compatible with mini6410, so I can
> test both DT and non-DT code paths. It also has a touchscreen using
> the on-SoC ADC. I'll give it a try this weekend. I'll try to review
> the series as well.
> 
I also have smdk6410 board on my desk and maybe I can test this series
in the weekend. If anything I'll let you know.

Thanks,
Kukjin
