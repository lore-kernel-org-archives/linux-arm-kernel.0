From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Mar 2018 13:33:04 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <20180302121442.GB28931@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302103127.GA2081@amd>
 <CACRpkda-VLsMVqYx3Y6+3JtLJERhmeJZF5g4Gd9ecvgR1Nnr0A@mail.gmail.com>
 <20180302121442.GB28931@amd>
Message-ID: <CACRpkdawRd6aGpj7hjVPv7TZ+YqLjgJaqphkDnkX6xR+3Gx-xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 1:14 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> >> Ok, so this code looks pretty crazy to me: I tried removing the
>> >> "of_find_spi_gpio" part, and audio started working.
>> >
>> > Hmm. Looks like audio is working w/o any changes, too. Not sure why
>> > festival hung on me before.
>>
>> Does it mean that mainline is working find for you or
>> do we need to look deeper into the problem in the OF
>> lookup?
>
> It now works for me.
>
> (But take a look at the patch I sent -- I believe you are still
> overwriting return values in a bad way, and code is quite confusing).

I think that code is a result of piled fixes, so noone
really designed it to look like that.

I'll try to look at it, I am a bit afraid of the code since I've
broken so many things with it.

Yours,
Linus Walleij
