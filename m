From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 13 Nov 2017 15:55:01 +0000
Subject: [PATCH 3/5] dt-bindings: arm: Document Socionext MB86S71 and
 Fujitsu F-Cue
In-Reply-To: <4c5fdcbd-057f-12a2-55f4-ff5f85b80f64@suse.de>
References: <20170625170020.11791-1-afaerber@suse.de>
 <20170625170020.11791-4-afaerber@suse.de>
 <20170628164605.2gnvrv4g7jluzyrm@rob-hp-laptop>
 <CAK7LNATqjOMUajUCYVq=L6wWVTUEc1M7Po+KQ3M3Z=A7+FHX5w@mail.gmail.com>
 <51221840-b08e-45f1-5601-937fb15f3947@suse.de>
 <CAK7LNASYvdWq5rV6q5Xf4Zqjso3H+XQY9Z6byJgcgfN7wT6fog@mail.gmail.com>
 <a39e3d09-4182-ee54-c855-3817498b306a@suse.de>
 <CAKv+Gu8fkOhQCx-BsyTkottkk63dohzSqa8RhAgTDcMVcmFbxQ@mail.gmail.com>
 <3327258c-b222-248b-9550-7620a57328f5@suse.de>
 <CAKv+Gu98dns-VoWF6xc0h_2R7SjcA3+85KVhLyLDgOBenhXJRQ@mail.gmail.com>
 <4d589d7a-2035-085e-17c4-1b88785b59f9@suse.de>
 <CAKv+Gu-m-KYnsgyFBUuez3gRhwPF=_sD4fGpE6BDugzW9NUnsA@mail.gmail.com>
 <c3c5b129-cd30-335d-80fd-05e9e4756121@suse.de>
 <CAKv+Gu_Wkdd3EdOjKJYZN5Ypjodpu5kFU=Ubg9H5e6ER3zq8Mg@mail.gmail.com>
 <4c5fdcbd-057f-12a2-55f4-ff5f85b80f64@suse.de>
Message-ID: <CAKv+Gu9emoFge2+V92pW2vJcTyh=k7-bkpiFeiDu+d7MF9b1ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 November 2017 at 15:40, Andreas F?rber <afaerber@suse.de> wrote:
> Am 06.11.2017 um 12:28 schrieb Ard Biesheuvel:
>> On 6 November 2017 at 06:58, Andreas F?rber <afaerber@suse.de> wrote:
>>> Am 05.11.2017 um 04:39 schrieb Ard Biesheuvel:
>> [...]
>>>>
>>>> Again, I am not the one who is ranting here. You hit a nerve by
>>>> accusing me of 'rebelling against linux.git' while this is quite the
>>>> opposite of what I am doing.
>>>
>>> Actually you did confirm that point by starting an argument about not
>>> needing a central repository and you not liking Linux as the location.
>>> That was exactly what I meant with my original comment.
>>>
>>> Adding Actions Semi was somewhat easy as a new vendor and now - roughly
>>> a year after the board went to market - there's Linaro contributions
>>> from Mani that I'm thankful for.
>>>
>>> Whereas patches keep falling into a dark hole when there's already other
>>> work for a certain vendor, such as Marvell and now Socionext, with no
>>> one feeling responsible for either taking them or saying, "hey, we're
>>> not going to submit any conflicting DT bindings for SynQuacer because we
>>> use ACPI, so please go ahead with proposal X, thanks for your efforts".
>>>
>>> Don't complain about me ranting if you belittle my volunteer work that I
>>> believe Linaro and its partners should've done in the first place: If I
>>> can get an initial mainline PoC done as an individual on a few
>>> evenings/weekends, then the same should be super-easy for an
>>> organization with lots of engineers and paying member companies.
>>
>> The only person doing the ranting, rebelling and belittling in this
>> thread is you. I have never commented on the nature of your work, let
>> alone belittle it.
>
> You have stated your opinion that Device Trees don't belong in a central
> repository and that Linux was the wrong place for them.

Not as strongly as that, but ok.

> My contributions
> to Linux have been mainly such Device Trees and bindings, such as this
> patch series here.

Again, I don't have a clue what it is you work on, although I just
found out (from the other thread you started) that it involves a
Fujitsu not-quite-96board that shares IP with the SynQuacer SoC? It
was my understanding (from information I received from Socionext) that
any upstreaming efforts involving that SoC had been discarded. I guess
the Socionext and Fujitsu engineers are not talking to each other
either.

> Quod erat demonstrandum.

Mathematical proof usually involves inferring new facts from existing
facts. You have done nothing of the kind, and I am not sure what you
are so angry about, but I think it would be better to leave the
emotions out of it, and try to remain factual. Especially when it
comes to representing other people's statements.

-- 
Ard.
