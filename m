From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 09:17:22 +0100
Subject: [PATCH] pinctrl: capri: add dependency on OF
In-Reply-To: <52D9BC5B.30304@wwwdotorg.org>
References: <1389912312-16285-1-git-send-email-linus.walleij@linaro.org>
 <52D989C2.6030603@broadcom.com>
 <CACRpkdYVLF+CNcAc8=MiSRJJMBWy3LriDw271Bx=gjuuzdOatA@mail.gmail.com>
 <CACRpkdZ9OBkKaLuQbc1oz0uPePBtqttGyOwV02iFWZ+CT1gwnw@mail.gmail.com>
 <52D9BC5B.30304@wwwdotorg.org>
Message-ID: <CACRpkdZLDJ_+AnwXbPY9eEo8FHo8u8qy00Jc6Rr+9EUv+O5eiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 12:27 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/17/2014 04:13 PM, Linus Walleij wrote:
>> On Sat, Jan 18, 2014 at 12:12 AM, Linus Walleij
>> <linus.walleij@linaro.org> wrote:
>>> On Fri, Jan 17, 2014 at 8:51 PM, Sherman Yin <syin@broadcom.com> wrote:
>>>
>>>> Thanks for the fix, Linus.  While we're visiting this config, should we add
>>>> "depends on MACH_BCM_MOBILE" as well?
>>>
>>> No, it's nice to get the compile coverage.
>>
>> But maybe you can experiment with that special option that only
>> turns on the driver on other platforms to do compile test.
>
> a/k/a
> depends on XXX || COMPILE_TEST

Yep, thanks Stephen :-)

Linus Walleij
