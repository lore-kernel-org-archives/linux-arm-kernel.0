From: olof@lixom.net (Olof Johansson)
Date: Thu, 5 Apr 2012 21:45:12 -0700
Subject: [GIT PULL] ARM: OMAP: clock, powerdomain, clockdomain, hwmod
 fixes for early v3.4-rc (misc_devel_3.4 patches dropped)
In-Reply-To: <20120405224658.GI3785@atomide.com>
References: <alpine.DEB.2.00.1204050339510.10302@utopia.booyaka.com>
 <20120405224658.GI3785@atomide.com>
Message-ID: <CAOesGMjnKzA=BMPVHw0Jtsr2Lz+_ggAihaAyyVO3hWifUPd8Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 5, 2012 at 3:46 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Olof,
>
> * Paul Walmsley <paul@pwsan.com> [120405 02:45]:
>> Hi Tony,
>>
>> The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:
>>
>> ? Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)
>>
>> are available in the git repository at:
>>
>> ? git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending tags/omap-fixes-a2-for-3.4rc
>>
>> for you to fetch changes up to a9dd31b744a033b4324c93cec4ecb4c74061e2cf:
>>
>> ? Merge branches 'clock_fixes_3.4rc', 'clockdomain_fixes_3.4rc', 'hsmmc_erratum_2_1_1_128_refine_3.4rc1', 'hwmod_data_fixes_a_3.4rc', 'hwmod_fixes_a2_3.4rc' and 'powerdomain_fixes_a_3.4rc' into omap-fixes-a2-for-3.4rc-branch (2012-04-05 03:00:22 -0600)
>>
>> This version is intended to merge cleanly into your 'fixes' branch.
>
> If not too late for this round of fixes, can you please pull this
> set of fixes directly from Paul?
>
> I was planning on including this into my fixes yesterday, but
> two patches had to be dropped that Paul did last night.
>
> This one already has the signed tag ;)

Thanks, pulled.

Paul, thanks for using a signed tag with an overview. There's no need
to list the changes in the signed tag though -- "git pull --log" will
include them in the merge commit instead. In general Linus tends to
not like seeing redundant info in the tag text that can be derived
from the branch contents instead.


-Olof
