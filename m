From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 24 Apr 2012 09:42:35 +0200
Subject: [PATCH 3/3] ARM: dt: tegra_ventana: als and proximity sensor
 isl29018 support
In-Reply-To: <4F8FD709.60308@nvidia.com>
References: <1334645155-13799-1-git-send-email-ldewangan@nvidia.com>
 <1334645155-13799-4-git-send-email-ldewangan@nvidia.com>
 <4F8DF01D.9040900@wwwdotorg.org> <4F8FD709.60308@nvidia.com>
Message-ID: <CACRpkdY5_F91oxzTScoBehABDHZBgZy1HkDK1okUq2uTLHh=Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 11:12 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> On Wednesday 18 April 2012 04:05 AM, Stephen Warren wrote:
>>
>> On 04/17/2012 12:45 AM, Laxman Dewangan wrote:
>>>
>>> Add the device info for ALS and proximity sensor isl29018.
>>
>>
>> a) Perhaps the vendor prefix should be "isil" not "isl". Olof, can you
>> please comment here?
>>
>
> Any comments on this? I think "isil" is good as it is the symbol in nasdaq
> also: Intersil Corporation (ISIL).
> If no objection than I can send my next version of patch ;)
>
> Adding LinusW, Mark and Grant if they have any comment here.

Like most of the kernel people I don't care much about that as long
as the string is unique ... your pick is likely the best.

Linus Walleij
