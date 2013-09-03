From: bcousson@baylibre.com (Benoit Cousson)
Date: Tue, 03 Sep 2013 22:53:11 +0200
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.12 take #2
In-Reply-To: <CAOesGMgwRsEJaKb4-LF2SFO_nHT97EHrE1MSdXv4bE8Ja_OhDA@mail.gmail.com>
References: <522100FF.5030204@baylibre.com>
 <CAOesGMgwRsEJaKb4-LF2SFO_nHT97EHrE1MSdXv4bE8Ja_OhDA@mail.gmail.com>
Message-ID: <52264C37.9050109@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 03/09/2013 17:06, Olof Johansson wrote:
> Benoit,
>
> On Fri, Aug 30, 2013 at 1:30 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
>> Hi Kevin & Olof,
>>
>> Here is the updated version without the conflicting patch (ARM: dts: AM33XX: don't redefine OCP bus and device nodes) and with the signed tag.
>> There is still a small conflict with usb-next, but it is easily fixable, and already fixed by Stephen.
>
> Sorry, I wasn't able to get this pulled in before the merge window
> opened, so it'll unfortunately have to wait until 3.13. Please send a
> fresh pull request as soon as -rc1 is out.

Gosh :-(

That was just the update of the previous conflicting one. Did you remove 
the older version as well?

> It looks like a few of these are fixes (at least from the patch
> topics), we'd of course be happy to take those.

OK, I'll extract the fixes for 3.12-rc.

Regards,
Benoit
