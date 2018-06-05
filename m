From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 05 Jun 2018 21:58:46 +0800
Subject: [linux-sunxi] Re: [PATCH v2 00/26] arm64: allwinner: Add A64 DE2
 HDMI support
In-Reply-To: <20180605132539.m54xwfzfs6btrmtc@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518095913.nzl3sr5wn6cg4ra5@flea>
 <CAMty3ZC13J+bCWK_=9816Lu-5ctC0UfF4-XR3yNSpHdH8q8Faw@mail.gmail.com>
 <20180605132539.m54xwfzfs6btrmtc@flea>
Message-ID: <3B82C42E-31DE-4CD2-AA51-B27FED56C43D@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?6?5? GMT+08:00 ??9:25:39, Maxime Ripard <maxime.ripard@bootlin.com> ??:
>On Tue, Jun 05, 2018 at 06:23:57PM +0530, Jagan Teki wrote:
>> On Fri, May 18, 2018 at 3:29 PM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>> > On Fri, May 18, 2018 at 03:15:10PM +0530, Jagan Teki wrote:
>> >> Allwinner A64 has display engine pipeline like other Allwinner
>SOC's A83T/H3/H5.
>> >>
>> >> A64 behaviour similar to Allwinner A83T where
>> >> Mixer0 => TCON0 => LVDS/RGB/MIPI-DSI
>> >> Mixer1 => TCON1 => HDMI
>> >> as per Display System Block
>DiagramAllwinner_A64_User_Manual_V1.1.pdf
>> >>
>> >> This is second patch-set followed with previous RFC[1] and first
>series[2]
>> >> and merely concentrated on HDMI pipeline through TCON1 and rest
>will add eventually.
>> >>
>> >> This series fixed previous version comments
>> >> - about documenting fallback compatibles
>> >> - adding new compatible for mixer1
>> >> - support for multiple DW HDMI PHY clock parents (thanks, to
>Jernej)
>> >>
>> >> Note:
>> >> Pine64 boards are unable to get edid by default like other A64
>boards,
>> >> but forcing 'video=HDMI-A-1:1920x1080 at 60D' kernel command line can
>> >> create edid with display on penel.
>> >
>> > There's no point in trying to push this without the SRAM issue
>being
>> > solved. It is required, and won't be merged unless this is
>addressed.
>> 
>> is SRAM issue resolved? if so may be I will try to test it on top.
>
>I'd expect the one working on this to push a solution to solve this.

I'll do it soon. Currently I'm a little busy.

>
>Maxime
