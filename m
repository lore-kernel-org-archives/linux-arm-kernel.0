From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Nov 2017 11:28:05 +0000
Subject: [PATCH 3/5] dt-bindings: arm: Document Socionext MB86S71 and
 Fujitsu F-Cue
In-Reply-To: <c3c5b129-cd30-335d-80fd-05e9e4756121@suse.de>
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
Message-ID: <CAKv+Gu_Wkdd3EdOjKJYZN5Ypjodpu5kFU=Ubg9H5e6ER3zq8Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 November 2017 at 06:58, Andreas F?rber <afaerber@suse.de> wrote:
> Am 05.11.2017 um 04:39 schrieb Ard Biesheuvel:
[...]
>>
>> Again, I am not the one who is ranting here. You hit a nerve by
>> accusing me of 'rebelling against linux.git' while this is quite the
>> opposite of what I am doing.
>
> Actually you did confirm that point by starting an argument about not
> needing a central repository and you not liking Linux as the location.
> That was exactly what I meant with my original comment.
>
> Adding Actions Semi was somewhat easy as a new vendor and now - roughly
> a year after the board went to market - there's Linaro contributions
> from Mani that I'm thankful for.
>
> Whereas patches keep falling into a dark hole when there's already other
> work for a certain vendor, such as Marvell and now Socionext, with no
> one feeling responsible for either taking them or saying, "hey, we're
> not going to submit any conflicting DT bindings for SynQuacer because we
> use ACPI, so please go ahead with proposal X, thanks for your efforts".
>
> Don't complain about me ranting if you belittle my volunteer work that I
> believe Linaro and its partners should've done in the first place: If I
> can get an initial mainline PoC done as an individual on a few
> evenings/weekends, then the same should be super-easy for an
> organization with lots of engineers and paying member companies.

The only person doing the ranting, rebelling and belittling in this
thread is you. I have never commented on the nature of your work, let
alone belittle it.

I understand you are frustrated with how some of the upstreaming of
96boards is handled. I don't have anything to do with that. The only
96boards i have in my drawer (and never use) is an original HiKey.

I work for the enterprise group, not the 96boards team, and I make a
point of not working with vendor trees at all. The only reason I
submitted some patches to the upcoming release of the ERP is so that
we have an installer that works out of the box, but all the patches I
did contribute were already queued for v4.15 at that point.

> As I've pointed out, an ever-increasing frustration builds over Linaro
> continuing to announce new boards (such as SynQuacer) that will be the
> best since sliced bread, while neglecting the 96boards that are already
> on the market and equally are promoted under the "96Boards" brand.
> The Linaro CEO has been promoting the Orange Pi i96 in keynotes, so
> management is aware of that hardware, and yet not a single patch came
> from Xunlong, RDA Micro or Linaro. No patch review from RDA either. And
> my patches got stuck on the bindings not including interrupts property
> for the UART yet, since I still do not have their custom interrupt
> controller working... So the context here is that not just my 4.14+
> pulls got stuck but three other 96Boards patch series, too.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
> GF: Felix Imend?rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N?rnberg)
