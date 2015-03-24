From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Mar 2015 17:24:55 -0700
Subject: [PATCH v5 12/12] ARM: dts: sun6i: hummingbird: Add basic support
 for the WiFi module
In-Reply-To: <20150323221629.GG15676@lukather>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-13-git-send-email-wens@csie.org>
 <20150323221629.GG15676@lukather>
Message-ID: <CAGb2v64+-KW5JsAvHhvt4jFD=CAkf37D5XyJ4B1f0WUXWLBodA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 3:16 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Mar 10, 2015 at 07:59:23PM +0800, Chen-Yu Tsai wrote:
>> The Hummingbird A31 has an AMPAK AP6210 WiFi+Bluetooth module. The
>> WiFi part is a BCM43362 IC connected to MMC1 in the A31 SoC via SDIO.
>> The IC also takes a power enable signal via GPIO.
>>
>> The WiFi module supports out-of-band interrupt signaling via GPIO,
>> but this is not supported in this patch.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied, thanks!

Thanks, but I don't see this particular patch in dt-for-4.1 you just pushed.

ChenYu
