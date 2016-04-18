From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 19 Apr 2016 02:12:56 +0300
Subject: [PATCH 0/3] arm: dts: lpc32xx: update ssp / spi nodes
In-Reply-To: <1461014548.27294.10.camel@localhost>
References: <1460636437-21764-1-git-send-email-slemieux.tyco@gmail.com>
 <3938626.hTOUROu3U1@wuerfel> <5714664C.7080201@mleia.com>
 <1461014548.27294.10.camel@localhost>
Message-ID: <571569F8.3030905@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 19.04.2016 00:22, Sylvain Lemieux wrote:
> Hi Vladimir and Arnd,
> 
> On Mon, 2016-04-18 at 07:45 +0300, Vladimir Zapolskiy wrote:
>> Hi Arnd,
>>
>> On 16.04.2016 22:34, Arnd Bergmann wrote:
>>> On Thursday 14 April 2016 08:20:34 slemieux.tyco at gmail.com wrote:
>>>> From: Sylvain Lemieux <slemieux@tycoint.com>
>>>>
> ...
>>>>
>>> The patches look fine, but it's unclear what you want to happen with them
>>> as long as the maintainer situation is not resolved. I've seen patches
>>> from Vladimir and you recently, and none from Roland, so I think it would
>>> be good if one or both of you could officially step up to be maintainers
>>> and collect all patches to forward them to arm at kernel.org for inclusion.
>>
>> for v4.5 and v4.6 I collected my own patches from LAKML after review,
>> I started to do it for v4.7, but probably a bit later than desired.
>>
> Vladimir, would it be possible for you to add my change, after review 
> is done on LAKML, for the lpc32xx pull request you will do for 4.7?

definitely.

For your information I updated my tree https://github.com/vzapolskiy/linux.git
recently, for DTS changes you may want to rebase the changeset on top of
lpc32xx/dt branch.

By the way I plan to rename board DTS files to match lpc32*-*.dts pattern,
but I can postpone doing it until your changes are included.

>>> Once we have an agreement on who does this, please send a patch to
>>> update the MAINTAINERS file.
>>
>> I'll send a change on behalf of myself, at this point I don't think that
>> pure lpc32xx maintenance (deliberately here I exclude development!) task
>> takes more than 20 hours per month, which is affordable for me,
>> Sylvain please express your view.
>>
> I can provide support for pure lpc32xx maintenance task 
> (I also exclude development); I can free up to 10-15 hours a
> month for doing testing and patch review.

Sounds good, thank you. Do you want to take over maintenance on v4.8
cycle?

> Is there any documentation available on the process 
> to submit a merge request to the mailing list?
> 
> ...

As for me I thoroughly observe what other ARM SoC maintainers do, and
ask questions if something remains uncertain.

--
With best wishes,
Vladimir
