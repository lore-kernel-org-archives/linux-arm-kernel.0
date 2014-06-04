From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Jun 2014 12:37:52 -0700
Subject: mainline boot: 37 passed 4 failed
 (mainline/v3.15-rc8-4569-g3de0ef8)
In-Reply-To: <20140604090111.GE2520@sirena.org.uk>
References: <538e6a20.0168440a.7895.422b@mx.google.com>
 <CAOesGMg4ESoPVvCc4is7wpA8PVOOSDzh5=VZZ67NnJjD3jUzmw@mail.gmail.com>
 <20140604090111.GE2520@sirena.org.uk>
Message-ID: <CAOesGMgNgPaVryOhYa4NyMK_PeNYSH5vWsGYUPpyhXa8TQoBZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 4, 2014 at 2:01 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 03, 2014 at 06:26:14PM -0700, Olof Johansson wrote:
>> On Tue, Jun 3, 2014 at 5:36 PM, Olof's autobooter <build@lixom.net> wrote:
>
>> > [    2.816920] smps9: failed to get the current voltage
>
>> This seems to be from palmas registration failing, which in turns
>> causes vmmc regulator lookup to fail. See the errors about palmas-pmic
>> above.
>
> Always CC maintainers on things.

What maintainer did I not cc? I missed the linux-omap list but I
included you and Tony.


-Olof
