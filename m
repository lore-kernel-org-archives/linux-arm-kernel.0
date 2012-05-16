From: olof@lixom.net (Olof Johansson)
Date: Tue, 15 May 2012 23:17:36 -0700
Subject: [GIT PULL] Renesas ARM-based platforms: new boards support for
 v3.5
In-Reply-To: <201205151958.26035.arnd@arndb.de>
References: <201205112101.59949.rjw@sisk.pl>
 <CAOesGMj5op-U+-_dvP_cqMUQ7zgzbzvig2ueb2LQTf+4MSEc2Q@mail.gmail.com>
 <CANqRtoQTMKdKmATz5uxCtWaZcEPa2apt9WO4URdhiwEMnst5gw@mail.gmail.com>
 <201205151958.26035.arnd@arndb.de>
Message-ID: <CAOesGMg+2wXqMLwq8QrzbHPd98QFZJwuO1No0o0BXEAbhO2O-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 12:58 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 14 May 2012, Magnus Damm wrote:
>> > Also, I would prefer to only see one or a couple of defconfigs that
>> > can provide full build coverage for the various SoCs and boards, that
>> > would contain the superset of the required drivers to boot the
>> > supported boards, etc.
>>
>> I can check with my superiors if we can phase our sh7367 support. If
>> so then we have only A8 and A9 in tree which should be easy to support
>> with a single kernel configuration. Does that sound like something
>> that would simplify things for you?
>
> I think there is no need to go that far. Just providing a defconfig for
> all boards that can already run a common image would be a good step
> forward.
>
> Is there a technical reason why you cannot build sh7367 together with
> the ARMv7 based machines? Most other platforms that have both ARMv6 and
> ARMv7 just build them together, you just can't combine them with any
> ARMv4/v5 platform.

Sorry for the delay in answer, Magnus -- agree with Arnd here.

To clarify; I wasn't asking for you to remove the non-v7 platforms,
just to see if you could trim down the shmobile defconfigs to a
smaller number by creating a superset of the supported boards in one
or two configs.


-Olof
