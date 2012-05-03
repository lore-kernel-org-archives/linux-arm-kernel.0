From: cjb@laptop.org (Chris Ball)
Date: Thu, 03 May 2012 13:09:15 -0400
Subject: [PATCH 6.2/7] MMC: mmci: Enable Device Tree support for ux500
In-Reply-To: <20120503164501.GG897@n2100.arm.linux.org.uk> (Russell King's
 message of "Thu, 3 May 2012 17:45:01 +0100")
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-7-git-send-email-lee.jones@linaro.org>
 <CACRpkdYyP=V=aXtDuo_W4oDxH0UkQKq1x1HKG_z=zWHoWng6JQ@mail.gmail.com>
 <4F8BE5B0.4000900@linaro.org>
 <20120425185747.GC24211@n2100.arm.linux.org.uk>
 <4FA29E46.6040204@linaro.org>
 <20120503151253.GE897@n2100.arm.linux.org.uk>
 <4FA2A4A8.9010208@linaro.org>
 <20120503163008.GF897@n2100.arm.linux.org.uk>
 <4FA2B4A3.2040402@linaro.org>
 <20120503164501.GG897@n2100.arm.linux.org.uk>
Message-ID: <8762cdur7o.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 03 2012, Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 05:38:59PM +0100, Lee Jones wrote:
>> Would you be kind enough to cast your eye over the documentation patch  
>> as well please? I believe Chris is waiting on an Ack from you before he  
>> will pull it.
>>
>> [PATCH 7/7] MMC: mmci: Add required documentation for Device Tree bindings
>
> I'm not sure I'm the right person for doing that because I've hardly
> touched DT stuff.
>
> Provided the properties are sanely named, and the common properties between
> drivers is already sensibly separated, then I don't see there's much to
> comment on.
>
> One thing that might help is if the format of these descriptions were
> changed so that there was one file per subsystem documenting the common
> options, rather than (eg) every MMC driver documentating the same base
> options time and time again.

Arnd has a patch to add a single file description of MMC bindings, but
it's been a while since the last revision -- Arnd, is there anything we
can do to help get your bindings patch merged soon?

Lee, Arnd's Acked-by is fine for this patch, I can take it via MMC if
the MMC patches are self-contained.  I'm having trouble finding the
latest patchset in one place, though; could you send me a pointer to
it, or repost it to me and the MMC list with your ACKs included?

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
