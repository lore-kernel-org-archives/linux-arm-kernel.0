From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 21 Feb 2017 14:27:02 +0530
Subject: [PATCH 1/3] ARM: davinci: PM: Drop useless check for
 PM_SUSPEND_STANDBY
In-Reply-To: <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
 <1487347836-14427-2-git-send-email-geert+renesas@glider.be>
 <76eb3b09-80bd-eb5a-db32-744a7b9e1f2c@ti.com>
 <CAMuHMdVdMeY0WFrpG_k_Ahd_EcLVTgaTW7+Z1imGmzs67uLuHg@mail.gmail.com>
Message-ID: <5c0967c9-cd60-372e-9a06-5c83fb880425@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 February 2017 02:10 PM, Geert Uytterhoeven wrote:
> Hi Sekhar,
> 
> On Mon, Feb 20, 2017 at 9:30 AM, Sekhar Nori <nsekhar@ti.com> wrote:
>> On Friday 17 February 2017 09:40 PM, Geert Uytterhoeven wrote:
>>> As DaVinci uses the standard suspend_valid_only_mem() for its
>>> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
>>> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> Looks good to me. Whats the plan for applying the series. Do you want
>> the individual machine maintainers to apply their parts. Or some other?
> 
> I think the individual machine maintainers is the simplest.

Patch 1/3 applied to branch v4.12/soc of my tree.

Thanks,
Sekhar
