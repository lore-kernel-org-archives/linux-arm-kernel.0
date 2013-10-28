From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 10:16:53 -0700
Subject: [GIT PULL] Allwinner sunXi core additions for 3.13
In-Reply-To: <20131028041607.GB22890@quad.lixom.net>
References: <20131018171456.GA14419@lukather>
 <20131028041607.GB22890@quad.lixom.net>
Message-ID: <CAOesGMgXGc-Fd13_aJ2LBE_Kyx=k7nqfsgFWGJfw47rpEBfaaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 27, 2013 at 9:16 PM, Olof Johansson <olof@lixom.net> wrote:
> On Fri, Oct 18, 2013 at 07:14:56PM +0200, Maxime Ripard wrote:
>> Kevin, Olof,
>>
>> Please pull the following changes for the 3.13 merge window.
>>
>> Thanks!
>> Maxime
>>
>> The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:
>>
>>   Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)
>>
>> are available in the git repository at:
>>
>>   https://github.com/mripard/linux.git tags/sunxi-core-for-3.13
>
> Thanks, pulled into next/soc.

This caused conflicts (and build breaks) due to the .init_time removal
and thus the removal of sunxi_timer_init().

I've merged in the removal branch as a prereq and added a fixup patch
on top (see separate patch email). No action needed from you on this,
just cc:ing you the patch so you see it.


-Olof
