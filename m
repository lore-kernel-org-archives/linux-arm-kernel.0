From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 22 Sep 2011 11:28:23 +0530
Subject: [PATCH v16 01/12] OMAP2+: dmtimer: add device names to flck nodes
In-Reply-To: <20110922010031.GR2937@atomide.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
	<1316518227-28116-2-git-send-email-tarun.kanti@ti.com>
	<20110922010031.GR2937@atomide.com>
Message-ID: <CAC83Zv+2ro-=en0tpdvrs1Ejzyj9Od54YadqgG-Bhksjn+wcmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2011 at 6:30 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [110920 03:57]:
>> Add device name to OMAP2 dmtimer fclk nodes so that the fclk nodes can be
>> retrieved by doing a clk_get with the corresponding device pointers or
>> device names.
>>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com
>
> I've fixed the missing bracket in the email address ? ? ^^^
Thanks.
--
Tarun
>
> Tony
>
