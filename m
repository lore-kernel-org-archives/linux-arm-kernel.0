From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 28 Mar 2017 07:49:54 -0700
Subject: [PATCH v4 3/3] ARM64: dts: meson-gx: Add MALI nodes for GXBB and
 GXL
In-Reply-To: <149064443540.54062.12740186024138662455@resonance> (Michael
 Turquette's message of "Mon, 27 Mar 2017 12:53:55 -0700")
References: <1490177935-9646-1-git-send-email-narmstrong@baylibre.com>
 <1490177935-9646-4-git-send-email-narmstrong@baylibre.com>
 <m237e2iirk.fsf@baylibre.com>
 <149064443540.54062.12740186024138662455@resonance>
Message-ID: <m2d1d1bgml.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michael Turquette <mturquette@baylibre.com> writes:

> Quoting Kevin Hilman (2017-03-24 12:20:31)
>> Neil Armstrong <narmstrong@baylibre.com> writes:
>> 
>> > The same MALI-450 MP3 GPU is present in the GXBB and GXL SoCs.
>> >
>> > The node is simply added in the meson-gxbb.dtsi file.
>> >
>> > For GXL, since a lot is shared with the GXM that has a MALI-T820 IP, this
>> > patch adds a new meson-gxl-mali.dtsi and is included in the SoC specific
>> > dtsi files.
>> >
>> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> 
>> LGTM, I can apply this when the clk driver changes are merged (feel free
>> to let me know when that happens, in case I'm not paying attention.)
>
> Applied to clk-meson, a stable branch, which has been merged into
> clk-next.
>
> Kevin, the dtsi is all yours.

Thanks, I applied it...

>> 
>> <bikeshed>
>> nit: This series (and previous ones) use MALI, but I believe the correct
>> way is Mali. Could you standarize on that throughout the series?
>> </bikeshed>
>> 

... after s/MALI/Mali/ in the changelog.

Kevin
