From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 8 Feb 2012 18:52:34 +0100
Subject: [PATCH v3 00/20] ARM: OMAP3+: SmartReflex: bugfixes
In-Reply-To: <871uqdca5e.fsf@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
 <871uqdca5e.fsf@ti.com>
Message-ID: <CAORVsuWX=KSaLWP=Pe-u-Djh1-vTDkWBamr5vWe_eiPi5p9c+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Thu, Feb 2, 2012 at 8:23 PM, Kevin Hilman <khilman@ti.com> wrote:
> Jean Pihet <jean.pihet@newoldbits.com> writes:
>
>> Integrate the latest SmartReflex bufixes from Felipe Balbi [1] and
>> Nishant Menon [2], plus misc bugfixes.
>>
>> Based on latest master branch of the mainline git tree (3.3.0-rc1) [3], commit
>> 27ba234c8dfe86c96675d4ef275d1d3c1f5f7053.
>>
>> [1] http://marc.info/?l=linux-omap&m=132134699423547&w=2
>> [2] https://github.com/nmenon/linux-omap-ti-pm/commits/linux-omap-3.0
>> [3] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=shortlog
>
> Can you break this series up further?
>
> There is lots of stuff in this series that does not qualify as a fix or
> a cleanup. ?(specifically, all the ones starting with "introduce...").
>
> We need to keep fixes and cleanups separate from new features.
Just re-sent the series with the bugfixes and minor clean-ups only, as
'[PATCH v4 00/14] ARM: OMAP3+: SmartReflex: bugfixes and clean-ups'.
This is based on 3.3-rc2 from mainline.

The new functionality will be added as patch series on top of this one.

>
> Kevin

Thanks,
Jean
