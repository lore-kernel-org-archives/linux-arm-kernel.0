From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Nov 2017 22:51:44 +0100
Subject: [GIT PULL] Mediatek: soc driver updates for v4.15
In-Reply-To: <514a12ee-b31f-1be0-8e11-2ec0929dd34b@gmail.com>
References: <1ebc2f2d-033e-e8d6-86c8-32a67ebd55b7@gmail.com>
 <CAK8P3a1hCWV6Fp5wyiESbdZUsgSoGZywj55=0v9Az-TPt3GtyQ@mail.gmail.com>
 <514a12ee-b31f-1be0-8e11-2ec0929dd34b@gmail.com>
Message-ID: <CAK8P3a2Lk3_W0kcR2vfpEtAHVBavbQ-ZJ6DCbMqnYDqmFR7y5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 7:40 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> Hi Arnd,
>
> On 11/02/2017 04:35 PM, Arnd Bergmann wrote:
>> On Mon, Oct 23, 2017 at 12:10 AM, Matthias Brugger
>> <matthias.bgg@gmail.com> wrote:
>>>
>>> ----------------------------------------------------------------
>>> - add 32 bit read/write support to pwrap
>>> - add mt7622 support to pwrap
>>> - test build all mediatek soc drivers
>>> - fix compiler issues
>>> - clean up Kconfig description
>>
>> Pulled into next/soc. I see some bug fixes in here that I would have
>> marked 'Cc: stable at vger.kernel.org'
>> to get them backported into stable kernels. Could you please make sure
>> they are marked appropriately
>> in the future, and maybe (after the merge window) send a message to
>> stable at vger.kernel.org with a list
>> of the commits that you want backported but that are missing the tag? Thanks!
>>
>
> Do you refer to this commits?
> f32fbbadaf44 soc: mediatek: pwrap: fix fatal compiler error
> fb2c1934f305 soc: mediatek: pwrap: fix compiler errors

Yes.

> They are actually fix problems in the very same pull request.

Ok, thanks for checking!

     Arnd
