From: olof@lixom.net (Olof Johansson)
Date: Wed, 6 Mar 2013 17:50:20 -0800
Subject: [PATCH] cpufreq: ARM big LITTLE: Add generic cpufreq driver and
 its DT glue
In-Reply-To: <20130307014657.GA7426@quad.lixom.net>
References: <f20e3c5e822c4bd28a3b71264d73143cc1f850b0.1362458878.git.viresh.kumar@linaro.org>
 <20130307014657.GA7426@quad.lixom.net>
Message-ID: <CAOesGMiOBxEHVgkr=K_4JVQ6+0Swy1uRmHaS8QwRxTJKs3J2Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 6, 2013 at 5:46 PM, Olof Johansson <olof@lixom.net> wrote:

> This binding makes no sense to me. It needs to be substantially better
> documented, not just a couple of sentences that people that understand
> bit.LITTLE thoroughly can make sense of.
>
> It also duplicates the cpu binding. I suspect this should instead be done
> through additions of the cpu bindings instead of duplication. So this needs to
> be substantially reworked.

Also, _ALWAYS_ cc devicetree-discuss on new bindings. get_maintainer
tells you to do so.


-Olof
