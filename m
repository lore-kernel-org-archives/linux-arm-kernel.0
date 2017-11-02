From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Nov 2017 22:55:33 +0100
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <0c3f8521-e0a6-a0d2-45b9-62d7c824818d@gmail.com>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
 <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
 <1509423579.10793.10.camel@mtkswgap22>
 <e8fdd9a9-ce13-8804-aea0-46becc6f9730@gmail.com>
 <CAK8P3a0+9fChSbObS9boR8okHtO8u8_hr2Te+RjfRD0T54QYWQ@mail.gmail.com>
 <0c3f8521-e0a6-a0d2-45b9-62d7c824818d@gmail.com>
Message-ID: <CAK8P3a1Bh3_HtzdXgHX5a88uDOehtQnaqYebrOKO2Y8GWW7vhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 2, 2017 at 7:47 PM, Matthias Brugger <matthias.bgg@gmail.com> wrote:
>
>>>
>>> Arnd, I didn't found the pull request in your next/dt branch.
>>> Is there more clarification needed from our side?
>>
>> I'm still unsure about it., this looks like exactly the thing that the top-level
>> interrupt-map is supposed to handle fine.
>>
>> Can you send a pull request for the series without the pci child nodes for the
>> moment while we figure out what the exact problem is? We can take
>> whatever fix we come up with during the v4.15 -rc cycle then.
>
> Sure. I'll provide a new tag v4.14-next-dts32-2 without the patch.
> I will send a pull request shortly.

I was thinking with the patch but without the duplicated interrupt-map
properties
(or without the extra child nodes) but dropping the patch works for me too.

I was hoping that we could figure out whether it's a code bug that prevents
us from just parsing the parent interrupt-map correctly, or whether there is
something wrong with that map itself.

       Arnd
