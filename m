From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Mar 2015 11:38:54 +0100
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <CACRpkdacQ-MR+Sziu-TQXWr+1UCtBphZ5eNSWbJ2ZpCnH+o9JA@mail.gmail.com>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <20150312091427.GA4329@piout.net>
 <CACRpkdacQ-MR+Sziu-TQXWr+1UCtBphZ5eNSWbJ2ZpCnH+o9JA@mail.gmail.com>
Message-ID: <CACRpkdYptEuJYsSGJqmnDrewDcafzx5tqa8E+FC7BETon7X9fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 11:28 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Mar 12, 2015 at 10:14 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>
>> As part of the system timer cleanup, I'll actually be needing that
>> patch. Is it scheduled for inclusion or should I use "simple-bus" in the
>> meantime?
>
> No replies to the thread so I will send a pull request to ARM SoC cleanup
> branch.

Ah well I had some pending changes requested by Lee. Once Lee
ACK it for MFD and (hopefully) Bryan pitches in for LEDs, I'll post
a pull request.

BTW: Alexandre: your ACK or Reviewed-by would be appreciated ;)

Antione: if you're also using this, pls provide your ACK on the series.

Yours,
Linus Walleij
