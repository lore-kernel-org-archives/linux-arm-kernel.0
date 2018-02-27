From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Feb 2018 09:43:32 +0100
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <20180226231336.GA18565@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
Message-ID: <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 27, 2018 at 12:13 AM, Pavel Machek <pavel@ucw.cz> wrote:

> I did git bisect, and the winner seems to be:
>
> pavel at duo:/data/l/linux-n900$ git bisect bad
> c85823390215e52d68d3826df92a447ed31e5c80 is the first bad commit
> commit c85823390215e52d68d3826df92a447ed31e5c80
> Author: Linus Walleij <linus.walleij@linaro.org>
> Date:   Wed Dec 27 16:37:44 2017 +0100
>
>     gpio: of: Support SPI nonstandard GPIO properties

I have fixes queued for this, tried to send a pull request yesterday
but it turns out the fixes need fixing... OK I'm onto it anyways.

Yours,
Linus Walleij
