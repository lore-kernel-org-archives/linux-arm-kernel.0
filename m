From: carlo@caione.org (Carlo Caione)
Date: Sun, 10 Apr 2016 18:24:31 +0200
Subject: [GIT PULL] ARM: Amlogic: DT fix for v4.6-rc
In-Reply-To: <570A24E4.6090109@suse.de>
References: <CAOQ7t2arscn+pe4FpgzEL26rt3HtoMBP2ndSMvGQtqnDuU4pEg@mail.gmail.com>
 <7hvb3rlm47.fsf@baylibre.com> <570A24E4.6090109@suse.de>
Message-ID: <CAOQ7t2aKppmQ0_ue_su6vdYtDbneObHdc0A_4Y=na6DmvweHZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 10, 2016 at 12:03 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Am 09.04.2016 um 01:24 schrieb Kevin Hilman:
>> Carlo Caione <carlo@caione.org> writes:
>>
>>> This is a fix for v4.6-rc since the Meson8 / Meson8b platforms are
>>> currently broken.
>>>
>>> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
>>>
>>>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
>>>
>>> are available in the git repository at:
>>>
>>>   https://github.com/carlocaione/linux-meson tags/meson8-dt-fix
>>>
>>> for you to fetch changes up to 11ca873574c2314de9f0cf1adf8b3be88e4e19ae:
>>>
>>>   documentation: Fix pinctrl documentation for Meson8 / Meson8b
>>> (2016-03-30 19:51:57 +0200)
>>>
>>> ----------------------------------------------------------------
>>> With http://www.spinics.net/lists/devicetree/msg116771.html we split / refactor
>>> the pinctrl driver to have two different pinctrl devices for each bus on the
>>> Amlogic Meson8 / Meson8b SoCs.
>>> These are the missing patches for documentation and DT that weren't pulled into
>>> mainline with the driver changes.
>>>
>>> ----------------------------------------------------------------
>>
>> Strictly speaking, these aren't just documentation patches.  The missing
>> .dtsi changes were what was causing boot breakage.
>
> The above tag says "documentation and DT" and the subject says "DT fix"?

Yeah, I hoped that the PR message would have been enough.

Cheers,

-- 
Carlo Caione
