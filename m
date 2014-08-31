From: olof@lixom.net (Olof Johansson)
Date: Sun, 31 Aug 2014 10:19:04 -0700
Subject: [GIT PULL] ARM: OMAP2+: DRA72x/DRA74x basic support
In-Reply-To: <20140828170258.GH16006@atomide.com>
References: <alpine.DEB.2.02.1408280617360.21985@utopia.booyaka.com>
 <20140828170258.GH16006@atomide.com>
Message-ID: <CAOesGMiudDK71Pzo+k9iiKJAcJzobc5z4+cpcomeJyM1KzbvgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This one clearly falls into the category of new platform support, not
bugfixes. But it's pretty small so I'll pick it up this time.


-Olof

On Thu, Aug 28, 2014 at 10:02 AM, Tony Lindgren <tony@atomide.com> wrote:
> Arnd & Olof,
>
> Can you please pick this one up for the -rc cycle so the TI guys
> can boot test dra7 with mainline properly?
>
> Regards,
>
> Tony
>
> * Paul Walmsley <paul@pwsan.com> [140827 23:18]:
>> Hi Tony,
>>
>> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:
>>
>>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.17-rc/omap-dra72x-d74x-support-a
>>
>> for you to fetch changes up to f7f7a29bf0cf25af23f37e5b5bf1368b85705286:
>>
>>   ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists (2014-08-27 19:38:23 -0600)
>>
>> ----------------------------------------------------------------
>> Add basic subarchitecture support for the DRA72x and DRA74x.  These
>> are OMAP2+ derivative SoCs.  This should be low-risk to existing OMAP
>> platforms.
>>
>> Basic build, boot, and PM test logs are available here:
>>
>> http://www.pwsan.com/omap/testlogs/hwmod-a-early-v3.17-rc/20140827194314/
>>
>> ----------------------------------------------------------------
>> Rajendra Nayak (2):
>>       ARM: DRA7: Add support for soc_is_dra74x() and soc_is_dra72x() variants
>>       ARM: DRA7: hwmod: Add dra74x and dra72x specific ocp interface lists
>>
>>  arch/arm/mach-omap2/omap_hwmod.c          |  3 +++
>>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 22 ++++++++++++++++++++--
>>  arch/arm/mach-omap2/soc.h                 |  6 ++++++
>>  3 files changed, 29 insertions(+), 2 deletions(-)
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
