From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 16 Jan 2016 15:44:23 +0100
Subject: [PATCH, RESEND] ssb: mark ssb_bus_register as __maybe_unused
In-Reply-To: <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
References: <8128014.DbbgBtKY3z@wuerfel>
 <8760ywd5fe.fsf@kamboji.qca.qualcomm.com>
 <4037550.DMaVTE01Aq@wuerfel>
 <87bn8l7miw.fsf@kamboji.qca.qualcomm.com>
Message-ID: <CACna6ryvDFHqwJ3ExURcyFT2ZaT9fS9v36wCnJfze5BLnE88og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 January 2016 at 13:10, Kalle Valo <kvalo@codeaurora.org> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Thursday 14 January 2016 08:46:29 Kalle Valo wrote:
>>> I can take it. For historical reasons ssb patches go through my
>>> wireless-drivers trees.
>>
>> I found this in my backlog, and I believe it still applies. Can you take
>> that one too?
>
> I'm not sure what you mean here, I can take any ssb patch if it's ok for
> Michael or Rafal :)
>
> Just please submit the patch properly (with S-o-B line) and CC
> linux-wireless so that it goes to patchwork.

It was already sent once and Acked by Michael:
https://patchwork.kernel.org/patch/7543191/

The problem was not cc-ing linux-wireless so it wasn't picked by the
linux-wireless patchwork.

-- 
Rafa?
