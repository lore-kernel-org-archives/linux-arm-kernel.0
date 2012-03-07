From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Mar 2012 14:49:19 -0800
Subject: [GIT PULL] fix to use static declarations for samsung stuff
In-Reply-To: <201203071215.57828.arnd@arndb.de>
References: <013b01cce7f3$48c87e30$da597a90$%kim@samsung.com>
 <4F574CAE.6030903@samsung.com> <201203071215.57828.arnd@arndb.de>
Message-ID: <CAOesGMgDkWmwVxBRnoOzX-u8FhmXgS_MuLwAigDmGpnXEPwciw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 4:15 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 March 2012, Kukjin Kim wrote:
>> im wrote:
>> > Hi Russell, Arnd and Olof,
>> >
>> > Please pull following branch which is including fix to use static
>> > declarations for samsung stuff.
>> > ? git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> > next/cleanup-use-static
>> >
>> > I'm not sure it can be sent to upstream for v3.3 but if so, would be better.
>> >
>> Hi Arnd, Olof,
>>
>> I can't see this series in arm-soc yet. If missed, please pull from:
>> ? http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
>> next/cleanup-use-static
>>
>> As a note, I rebased it on top of arm-soc/depends/rmk/for-armsoc because
>> this touches same points(dma declaration part).
>>
>> If any problems, please kindly let me know.
>>
>
> Sorry, I must have missed this request, I can't remember seeing it before.
> The patches all look good, Olof will take care of getting them in.

Yep, pulled now. Apologies for missing it earlier.


-Olof
