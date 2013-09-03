From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Sep 2013 08:06:51 -0700
Subject: [GIT PULL] ARM: OMAP: Device Tree for 3.12 take #2
In-Reply-To: <522100FF.5030204@baylibre.com>
References: <522100FF.5030204@baylibre.com>
Message-ID: <CAOesGMgwRsEJaKb4-LF2SFO_nHT97EHrE1MSdXv4bE8Ja_OhDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

On Fri, Aug 30, 2013 at 1:30 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> Hi Kevin & Olof,
>
> Here is the updated version without the conflicting patch (ARM: dts: AM33XX: don't redefine OCP bus and device nodes) and with the signed tag.
> There is still a small conflict with usb-next, but it is easily fixable, and already fixed by Stephen.

Sorry, I wasn't able to get this pulled in before the merge window
opened, so it'll unfortunately have to wait until 3.13. Please send a
fresh pull request as soon as -rc1 is out.

It looks like a few of these are fixes (at least from the patch
topics), we'd of course be happy to take those.


-Olof
