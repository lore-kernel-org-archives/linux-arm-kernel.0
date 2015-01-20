From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 20 Jan 2015 14:59:43 +0100
Subject: [PATCH v2 02/11] ARM: tegra: Use the generated pinmux data
In-Reply-To: <54B7F7F7.1020202@wwwdotorg.org>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-3-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F7F7.1020202@wwwdotorg.org>
Message-ID: <CAAObsKAaanrrSYd7gmLAS4K_G9fuU=WmsMXQk0G85hfy_XdE5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 January 2015 at 18:25, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>
>> Google has submitted a board config for the pinmux programming of the
>> Nyan Big board. Use the whole of it as it's generated to make it easier
>> to update as the configuration gets fixed in the future.
>
>
> Submitted to where? I assume you mean tegra-pinmux-scripts. I don't see a
> Nyan/Nyan-big configuration there yet. IIRC (and I might not) one was
> posted, but there were some review comments that aren't yet addressed?

Yeah, that's what I meant by submitted. TTBOMK the v2 doesn't have any
comments pending of being addressed?

I have just sent a pinmux config file for the blaze that just changes
the configuration of usb_vbus_en0, usb_vbus_en1 and dp_hpd pins.

Regards,

Tomeu
