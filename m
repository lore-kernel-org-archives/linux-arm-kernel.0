From: harinikatakamlinux@gmail.com (Harini Katakam)
Date: Thu, 7 Dec 2017 19:00:40 +0530
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
In-Reply-To: <20171207104915.fdqkj35ga2yxeg3n@ninjato>
References: <20170916030252.10680-1-amworsley@gmail.com>
 <20171005120125.nnhomwg2e2twbaqm@ninjato>
 <CA+Y=x3=Ab-tZt-32Ve1qTB=REuQAZnGbX72ZeNpyX3EX7cR0pg@mail.gmail.com>
 <20171013184646.cy5gmpwrxbacje3m@ninjato>
 <CAFcVECJTUu7Kwd-2hx=4=iGwKFnpTAebR3ffjJHQLHKDZ3T4aw@mail.gmail.com>
 <CA+Y=x3nnQ0hQkBaGQ4+MDZsVgpdFCYqaMae9UrJ2vOOuAD9FdQ@mail.gmail.com>
 <CAFcVECK85xW_8oxVQGsHBGyZ4_5bcghpbonqDH-8tLp+Mwq=xQ@mail.gmail.com>
 <CA+Y=x3kpy0LE-mqjKWS8QWy7qzS2pNdDMHpDqZXRGvdt-UbYcA@mail.gmail.com>
 <CAFcVECLWwo+OxSGAGYJfMSesjNT51X+Cwk+E_-RQk7gsEXy2YQ@mail.gmail.com>
 <20171207104915.fdqkj35ga2yxeg3n@ninjato>
Message-ID: <CAFcVECKVR5fmVipB1cN97COecULcHtJFrediTsriSuwrm_A_Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram and Andrew,

On Thu, Dec 7, 2017 at 4:19 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > I attach a patch of the changes to the i2c driver showing my debug in
>> > this driver.
>> > As I said I am happy to send more verbose bug output - I have about 36
>> > odd runs with 9 occurences of the bug.
>> > Once it happen twice in the one run
>> >
>> > I include the crashing line from the runs where the bug occured (I
>> > added more diagnostics as the runs progressed):
>>
>> I'll check with out HW team as well and check your flow to
>> see if we can reproduce it; will also check if the existing errata
>> has larger scope.
>> I'll let you know if we require further assistance with debug
>> next week.
>
> Any news here?

Sorry for the delay.
I've checked the known errata and confirmed that it wont
affect this use case. And we haven't been able to hit this
issue on our HW (with eeprom slave devices).
I will add my colleague looking into this further to debug.

Regards,
Harini
