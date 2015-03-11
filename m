From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Mar 2015 11:11:49 +0800
Subject: [PATCH v5 12/12] ARM: dts: sun6i: hummingbird: Enable the onboard
 WiFi module
In-Reply-To: <20150310213218.GH5085@lukather>
References: <1425988764-23618-1-git-send-email-wens@csie.org>
 <1425988764-23618-14-git-send-email-wens@csie.org>
 <20150310213218.GH5085@lukather>
Message-ID: <CAGb2v66zJcBBpLZFjNyugjRzt8SppQ0VbFD+pMqVYdK4EKg-fQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 5:32 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Mar 10, 2015 at 07:59:24PM +0800, Chen-Yu Tsai wrote:
>> The Hummingbird A31 has an AMPAK AP6210 WiFi+Bluetooth module. The
>> WiFi part is a BCM43362 IC connected to MMC1 in the A31 SoC via SDIO.
>> The IC also takes a power enable signal via GPIO. This is supported
>> with the new power sequencing bindings.
>>
>> The WiFi module supports out-of-band interrupt signaling via GPIO,
>> but this is buggy and not enabled yet.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> There's two almost identical patches 12/12. Which one am I suppose to
> apply?

This one is the right one. I forgot to clear the patches after changing
the description. The "buggy" part in the description is probably not
needed. Hans explained that the SD resets have nothing to do with
interrupt handling.


ChenYu
