From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 16 May 2012 08:48:23 +0100
Subject: [PATCH 7.2/15] ARM: ux500: Disable SMSC911x platform code
 registration when DT is enabled
In-Reply-To: <CACRpkdZziyAtUvDPhzvdhaUSFYQ5QjTEDJKWTQOaB4D+7A+qrQ@mail.gmail.com>
References: <1334867804-31942-1-git-send-email-lee.jones@linaro.org>
 <CACRpkdZzAQNJ9ejKJJQJhEPjO9VO+fPHmPeCErg8XOj-dLc3gA@mail.gmail.com>
 <4F967986.6090808@linaro.org> <201205031257.52100.arnd@arndb.de>
 <CACRpkdaLG+LwNpKX_52+scLrNbezvRXEuCfF5CAb4XFOSD4xag@mail.gmail.com>
 <4FB35343.4090407@linaro.org>
 <CACRpkdZziyAtUvDPhzvdhaUSFYQ5QjTEDJKWTQOaB4D+7A+qrQ@mail.gmail.com>
Message-ID: <4FB35BC7.8060709@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/05/12 08:38, Linus Walleij wrote:
> On Wed, May 16, 2012 at 9:12 AM, Lee Jones<lee.jones@linaro.org>  wrote:
>> On 03/05/12 18:14, Linus Walleij wrote:
>
>> In the pull request was:
>>> @@ -612,7 +612,6 @@ static struct platform_device *snowball_platform_devs[] __initdata = {
> (...)
>> But this made it into arm-soc:
>>> @@ -605,7 +605,6 @@ static void __init mop500_uart_init(struct device *parent)
>
> Two exactly identical arrays just on different line numbers, yeah...

Eh? Did you quote the wrong line?

>> Somehow the incorrect *_platform_devs[] was amended.
>> Some kind of git automatic conflict resolution error?
>
> Probably a patch -p1<  foo.patch error, that's the kind of stuff
> it causes. My fault, certainly. The problem is that I don't see
> the problem with git diff, it looks correct there too.

No I don't think it has anything to do with what you did.

> I thought that my bad branch had been replaced with a
> different (correct) pull request from you though :-/

I did, hence why it's not your fault. However, I've checked the 
pull-request I sent and it contains the _correct_ patch. This must have 
happened during the pull or with a subsequent git action (rebase?).

> So how to we fix it? With an incremental patch on top?

I can provide you with a patch really quickly if that's the way you want 
to go.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
