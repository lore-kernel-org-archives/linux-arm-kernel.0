From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Nov 2018 12:39:44 +0100
Subject: Aw: Re: Re: [PATCH v5 05/12] drm: mediatek
In-Reply-To: <trinity-cbebb6c8-0084-49a7-b07a-8ea3dbd13e6e-1542710054258@3c-app-gmx-bs39>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-6-matthias.bgg@kernel.org>
 <1542605939.32082.12.camel@mtksdaap41>
 <0a02edf9-78da-dde9-4b69-38c4719b711b@gmail.com>
 <1542686700.9073.15.camel@mtksdaap41> <1542686982.26483.1.camel@mtksdaap41>
 <trinity-8f0fde8e-5ef3-4272-b009-49e180c934eb-1542702383860@3c-app-gmx-bs39>
 <1192d203-fcd1-47b0-00bc-9d513e5ffc3e@gmail.com>
 <trinity-cbebb6c8-0084-49a7-b07a-8ea3dbd13e6e-1542710054258@3c-app-gmx-bs39>
Message-ID: <4745c3ab-e6af-309e-d1c4-f07d937fb9af@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/11/2018 11:34, Frank Wunderlich wrote:
> right this branch based on rc1 with some other commits, but v5-patches are applied on Oct 3rd (listed in Oct 5th)
> 
> frank at frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:10]$ git checkout 4.19-hdmiv5
> Already on '4.19-hdmiv5'
> Your branch is up to date with 'origin/4.19-hdmiv5'.
> frank at frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:13]$ make kernelversion
> 4.19.0-rc1
> frank at frank-N56VZ:/media/data_ext/bpi-r2-kernel/github
> [11:29:19]$ git log --oneline
> ...
> fc14b8c515de drm/mediatek: add a error return value when clock driver has been prepared
> 0dc856306aaf drm/mediatek: implement connection from BLS to DPI0
> 3d0a6749bfe3 drm/mediatek: add hdmi driver for MT2701 and MT7623
> b03e1b353b28 drm/mediatek: add support for SPDIF audio in HDMI
> c5564966272e drm/mediatek: separate hdmi phy to different file
> dee3954828db drm/mediatek: add dpi driver for mt2701 and mt7623
> a838ae8b415c drm/mediatek: convert dpi driver to use drm_of_find_panel_or_bridge
> f7f9f7c080ae drm/mediatek: add clock factor for different IC
> be1a5447330f drm/mediatek: adjust EDGE to match clock and data
> fec4504ea318 drm/mediatek: move hardware register to node data
> db992e429b9c drm/mediatek: add refcount for DPI power on/off
> ...

This patches are not part of this patch series.

> 
> compared with 4.19.0-release there is merge https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?id=53b3b6bbfde6aae8d1ededc86ad4e0e1e00eb5f8 which seems to break v5-patches
> 
>> Gesendet: Dienstag, 20. November 2018 um 11:14 Uhr
>> Von: "Matthias Brugger" <matthias.bgg@gmail.com>
>> An: "Frank Wunderlich" <frank-w@public-files.de>, "CK Hu" <ck.hu@mediatek.com>
>> Cc: mark.rutland at arm.com, devicetree at vger.kernel.org, sean.wang at kernel.org, "Matthias Brugger" <mbrugger@suse.com>, airlied at linux.ie, mturquette at baylibre.com, sean.wang at mediatek.com, sboyd at codeaurora.org, linux-kernel at vger.kernel.org, dri-devel at lists.freedesktop.org, wens at csie.org, robh+dt at kernel.org, rdunlap at infradead.org, laurent.pinchart at ideasonboard.com, p.zabel at pengutronix.de, matthias.bgg at kernel.org, ulrich.hecht+renesas at gmail.com, linux-mediatek at lists.infradead.org, linux-clk at vger.kernel.org, linux-arm-kernel at lists.infradead.org
>> Betreff: Re: Aw: Re: [PATCH v5 05/12] drm: mediatek
>>
>>
>>
>> On 20/11/2018 09:26, Frank Wunderlich wrote:
>>> Hi,
>>>
>>> i got v5-patches working on bpi-r2 (mt7623) with a Patch from Ryder.lee and 2 from Bibby Hsieh on 4.19-rc1
>>>
>>> https://github.com/frank-w/BPI-R2-4.14/commits/4.19-hdmiv5
>>>
>>
>> I don't see the patches applied to this tree. Apart from that this tree has a
>> lot of other patches applied. It differs greatly from mainline, so nothing we
>> should discuss on this mailinglist.
>>
>> Regards,
>> Matthias
>>
>>> but after i tried to include them on 4.19.2, i got a strange behaviour (stretched and pink font instead of white/grey)
>>>
>>> see here for detailed info:
>>>
>>> http://forum.banana-pi.org/t/kernel-4-19-rc1-for-testers/6618/75
>>>
>>> there are some patches between rc1 and final which i tried to revert, but no luck till now (cannot revert, no effect on the issue or no output). Had informed Bibby Hsieh...
>>>
>>> is there any idea, why this happen?
>>>
>>> regards Frank
>>>
>>
