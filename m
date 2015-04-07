From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Apr 2015 11:00:47 +0200
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <CAOesGMhz6WPweQFXfPhTO6Pz5L4Z1Si6YGiCRCiFD9B5qB9tVw@mail.gmail.com>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
 <CAOesGMhz6WPweQFXfPhTO6Pz5L4Z1Si6YGiCRCiFD9B5qB9tVw@mail.gmail.com>
Message-ID: <CACRpkdZzT1p-a2uReWeYn12D8e5nyBRE4ovJ6GuqEdFB3AdGHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 3, 2015 at 8:34 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Mar 3, 2015 at 1:32 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> +
>> +foo at 1000 {
>> +               compatible = "syscon", "simple-mfd";
>> +               reg = <0x010000 0x1000>;
>> +
>> +               led at 08.0 {
>
> This doesn't seem to be a typo, you're using a period in the unit
> address. I've never seen that done before, usually commas are used
> instead.
>
> Was there a reason for going with period?

It was the suggested syntax from DT binding maintainer Rob Herring in
July last year:
http://marc.info/?l=linux-arm-kernel&m=140629736615939&w=2

Yours,
Linus Walleij
