From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Oct 2014 14:23:22 -0700
Subject: [GIT PULL] arm: pxa: fixes against v3.18-rc1
In-Reply-To: <CAOesGMh1N5-=4AzZDNeNsixW618F_HwFRnNFmKUmhxVyLS2PuQ@mail.gmail.com>
References: <87h9yy0wra.fsf@free.fr> <87ppdjlwc9.fsf@free.fr>
 <41963113.yZasLWq6Hk@wuerfel> <87siiak80u.fsf@free.fr>
 <CAOesGMh1N5-=4AzZDNeNsixW618F_HwFRnNFmKUmhxVyLS2PuQ@mail.gmail.com>
Message-ID: <CAOesGMiJHLEyAjZ-EVqmFO90XOThaJnxhP0=QWe9MFoyqCPr4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 26, 2014 at 2:21 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Oct 26, 2014 at 11:20 AM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> On Wednesday 22 October 2014 21:48:22 Robert Jarzmik wrote:
>>>> I think I messed up the email address, thinking the alias arm at linux.org
>>>> represented the arm soc maintainers.
>>>>
>>>> As this is the first time I ask you to pull, it might be time to educate me with
>>>> what I'm doing wrong, either in my timing, the content, or anything else.
>>>>
>>>> This was the pull request I wanted to send.
>>>>
>>>
>>> It's arm at kernel.org, not arm at linux.org.
>>>
>>>       Arnd
>>
>> Okay, I'll resend it for -rc3 I suppose.
>
> Sorry I missed it because it wasn't sent to that address and I usually
> only look in that folder for fixes.
>
> I'll pull it in now so that we've got it queued for -rc3.

Oh! Also, the ref you've used in the pull request isn't the public
one. You probably want to add another remote to your repo as the
official public URL to it, and use that as the argument for
request-pull.

(I have two remotes in my local arm-soc repo: one is the usual origin,
which is the regular public gitserver URL for arm-soc.git, and another
that I use to push to that goes over SSH, etc.)


-Olof
