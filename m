From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Jan 2015 09:20:42 -0700
Subject: [PATCH v2 02/11] ARM: tegra: Use the generated pinmux data
In-Reply-To: <CAAObsKAaanrrSYd7gmLAS4K_G9fuU=WmsMXQk0G85hfy_XdE5Q@mail.gmail.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421338359-27467-3-git-send-email-tomeu.vizoso@collabora.com>
 <54B7F7F7.1020202@wwwdotorg.org>
 <CAAObsKAaanrrSYd7gmLAS4K_G9fuU=WmsMXQk0G85hfy_XdE5Q@mail.gmail.com>
Message-ID: <54BE805A.3060300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2015 06:59 AM, Tomeu Vizoso wrote:
> On 15 January 2015 at 18:25, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 01/15/2015 09:12 AM, Tomeu Vizoso wrote:
>>>
>>> Google has submitted a board config for the pinmux programming of the
>>> Nyan Big board. Use the whole of it as it's generated to make it easier
>>> to update as the configuration gets fixed in the future.
>>
>>
>> Submitted to where? I assume you mean tegra-pinmux-scripts. I don't see a
>> Nyan/Nyan-big configuration there yet. IIRC (and I might not) one was
>> posted, but there were some review comments that aren't yet addressed?
>
> Yeah, that's what I meant by submitted. TTBOMK the v2 doesn't have any
> comments pending of being addressed?

There's a thread where you and Andrew are discussing the settings for a 
bunch of the pins, and the differences between Big and Blaze. It didn't 
seem to me that the resolution was that the V2 patch was fine as is, but 
perhaps that's what the thread meant!

Either way, it'd be nice if Andrew or someone else from ChromeOS could 
give an acked-by/reviewed-by for the patch if it's OK as is. That way, 
I'll know it's good without any doubts.
