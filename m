From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 12 Jan 2013 09:54:17 +0100
Subject: [PATCH 0/2] Add GPIO driver for Allwinner SoCs
In-Reply-To: <CACRpkdZQAim4_3E6RG=d4pJi80B6W-xzW7n=Od86VJNcPO4FVw@mail.gmail.com>
References: <1357317909-12458-1-git-send-email-maxime.ripard@free-electrons.com>
 <CAOesGMiTZvLJ6cXwMFsFc6pBGoLUEkV+WMrDOqqCcs_TEnTtUw@mail.gmail.com>
 <CACRpkdZQAim4_3E6RG=d4pJi80B6W-xzW7n=Od86VJNcPO4FVw@mail.gmail.com>
Message-ID: <50F124B9.30000@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2013 12:13, Linus Walleij wrote:
> On Sat, Jan 5, 2013 at 4:35 PM, Olof Johansson <olof@lixom.net> wrote:
> 
>> I haven't looked closely at the patch yet, but this is a case where it
>> makes sense to merge the gpio/pinctrl patch through Linus/Grant's
>> tree, and merge the dtsi update through arm-soc -- while you need
>> both, nothing is broken by having just one or the other, so taking the
>> separate merge paths are fine.
>>
>> Linus, Grant, sound ok to you?
> 
> Sure. But I have requested a few changes to the patch set...

And we need to merge the pinctrl patches first also.

Maxime

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
