From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 06 Oct 2017 16:10:43 -0700
Subject: [PATCH] ARM64: dts: meson-gxbb-nexbox-a95x: Enable USB Nodes
In-Reply-To: <89e9980a-2ca6-4509-b9d5-36aac433b9bd@baylibre.com> (Neil
 Armstrong's message of "Thu, 5 Oct 2017 15:23:34 +0200")
References: <20171005132118.2150-1-peter@korsgaard.com>
 <89e9980a-2ca6-4509-b9d5-36aac433b9bd@baylibre.com>
Message-ID: <7hlgkn7tzg.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 05/10/2017 15:21, Peter Korsgaard wrote:
>> Enable both gxbb USB controllers and add a 5V regulator for the OTG port
>> VBUS, similar to p20x.
>> 
>> Signed-off-by: Peter Korsgaard <peter@korsgaard.com>

[...]

> Indeed, I forgot to add USB to this board,
> Thanks
>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Applied to v4.15/dt64,

Thanks,

Kevin
