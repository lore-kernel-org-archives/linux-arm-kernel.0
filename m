From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Feb 2016 09:46:11 +0000
Subject: [PATCH v3 7/7] arm64: dts: r8a7795: Add CA53 L2 cache-controller
 node
In-Reply-To: <CAMuHMdX=Kgb-i+QpP=yNO2e6nw7sXuCutXPoK0U9NwK-OyANFA@mail.gmail.com>
References: <1455568715-20880-1-git-send-email-geert+renesas@glider.be>
 <1455568715-20880-8-git-send-email-geert+renesas@glider.be>
 <56C2C534.30704@de.bosch.com>
 <CAMuHMdX=Kgb-i+QpP=yNO2e6nw7sXuCutXPoK0U9NwK-OyANFA@mail.gmail.com>
Message-ID: <56C2EFE3.6010900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 16/02/16 07:12, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Tue, Feb 16, 2016 at 7:44 AM, Dirk Behme <dirk.behme@de.bosch.com> wrote:

[...]

>>
>> As we don't have any CA53 in the device tree yet, and it was rejected to add
>> it, I'd think that we don't want these unused entries at the moment.
>
> This is a preparatory step for adding the SYSC PM Domains.
>
>> I'd propose to add the CA53 entries, first. And then add their L2 cache
>> entries.
>>
>> Based on the outcome of the discussion for the CA57 we have to see if we
>> want to add the unused cache-unified and cache-level, then, too.
>
> These are specified by ePAPR, as I said before.
> Remember, DT describes the hardware, not what Linux (or any other OS) is
> using.
>

I completely agree and I mentioned the same in the other email.

-- 
Regards,
Sudeep
