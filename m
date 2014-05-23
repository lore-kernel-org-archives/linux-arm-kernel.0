From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 May 2014 15:01:47 -0700
Subject: [GIT PULL] at91: DT for 3.16 at91-dt3 #3
In-Reply-To: <20140523215544.GI13642@piout.net>
References: <1400775895-31183-1-git-send-email-nicolas.ferre@atmel.com>
 <201405232327.52312.arnd@arndb.de>
 <20140523215544.GI13642@piout.net>
Message-ID: <CAOesGMioT1QSaBY6vs30E5ez5OouzaHhZE8dTEK1Rf0NekCZjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 2:55 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 23/05/2014 at 23:27:51 +0200, Arnd Bergmann wrote :
>> On Thursday 22 May 2014, Nicolas Ferre wrote:
>> > Another AT91 DT pull-request for 3.16. This one is the conversion of two more
>> > SoC to Common Clock Framework (aka CCF). I identified it as a "DT" pull-request
>> > but it modifies slightly a couple of files in mach-at91 (use of a configuration
>> > option).
>>
>> Four done, four more to go? Nice progress!
>>
>
> I'm on it ;) I actually have two more almost ready but I will submit the
> remaining four for 3.17. I don't think this is urgent enough to rush it
> and I'd like to test it enough before we start removing the old clock
> implementation and board files.

I think we should spend some more time discussing DTS naming instead!

(Just kidding, good progress. Agreed, let it go in when it's ready,
it's why we do frequent kernel releases)


-Olof
