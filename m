From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 20 Jul 2012 13:57:52 +0530
Subject: [PATCH 1/3] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <20120720075652.GA31866@S2101-09.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-2-git-send-email-shawn.guo@linaro.org>
 <CAMQu2gz3XXQdG3T=jSboZ8cW-gKO33k7+OUPaQpjpUcnitk_RA@mail.gmail.com>
 <20120720075652.GA31866@S2101-09.ap.freescale.net>
Message-ID: <CAMQu2gzB65dQfx6pYc=Z0KD2NYJ1zdrAgQcS_ctE9chYjQH8bA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

n Fri, Jul 20, 2012 at 1:26 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Jul 20, 2012 at 12:06:50PM +0530, Shilimkar, Santosh wrote:
>> On Thu, Jul 19, 2012 at 9:24 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> >
>> > From: Richard Zhao <richard.zhao@linaro.org>
>> >
>> > If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
>> > arch has different per-cpu loops_per_jiffy definition.
>> >
>> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
>> > Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
>> > ---
>> Nice. Avoids other driver duplicating this code.
>> May be you can keep Richard's credit in commit too.
>>
> It's all Richard's credit in the commit.
>
Sorry.... I missed that :-(
