From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Nov 2013 05:21:03 +0530
Subject: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu
 node in DT.
In-Reply-To: <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1383247111-26834-4-git-send-email-andrew@lunn.ch>
 <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
Message-ID: <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
>> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
>> is also an interrupt generated when the DFS hardware completes a
>> change of frequencey. Add these to the cpu node in DT.
>>
>> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
>> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>
> I need someone with DT bindings knowledge to ACK this for me.

I can do that, but this set has to be rebased over all the latest developments
in cpufreq core before getting posted again..

@Andrew: you can add my: Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
for this patch..
