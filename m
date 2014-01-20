From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 19 Jan 2014 23:43:54 -0800
Subject: [PATCH 0/3] ARM: OMAP: clk-next-omap emergency fixes
In-Reply-To: <20140118175020.GF7235@atomide.com>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
 <20140117213729.4167.55693@quantum> <20140118175020.GF7235@atomide.com>
Message-ID: <CAPtuhTg8YO6nG8rL8ZFTp78m_AqHnoaZ-LtTTW3_o3QKmRoovA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 18, 2014 at 9:50 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Mike Turquette <mturquette@linaro.org> [140117 13:39]:
>> Quoting Tero Kristo (2014-01-17 12:25:37)
>> > Hi,
>> >
>> > Quick emergency band-aid for the build breakages introduced in clk-next
>> > by Mike. I didn't have time to test this out (Nishanth will provide some
>> > logs) and I will leave the decision whether/how to use these patches or not
>> > to Tony + Mike.
>> >
>> > I also pushed a test branch based on top of clk-next here:
>> > tree: https://github.com/t-kristo/linux-pm.git
>> > branch: clk-next-omap-fixes
>>
>> Thanks Tero. I force updated the clk tree with the right branch, so
>> these should not be necessary now.
>
> Great, and just for reference if I did not do it yet for these:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

I applied your Ack to entire series (these fixes, clock drivers and
arch/arm changes).

Regards,
Mike
