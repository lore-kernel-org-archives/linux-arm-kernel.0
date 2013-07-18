From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 18 Jul 2013 13:23:42 +0530
Subject: [RFC PATCH v2 11/15] cpufreq: kirkwood-cpufreq: remove device
 tree parsing for cpu nodes
In-Reply-To: <20130717144355.GE1026@lunn.ch>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374069984-20567-12-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <20130717144355.GE1026@lunn.ch>
Message-ID: <CAKohpomoxFBQjDh12OkFB-NnuKzf0u-ZiotF7qa8Cs8Sa8nvNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 July 2013 20:13, Andrew Lunn <andrew@lunn.ch> wrote:
> Are we not going a bit backwards here? You are replacing two lines
> with 10 lines.
>
> How about putting these 10 lines into some helper,
> of_get_cpu_device()?  It would be useful for spear, kirkwood and
> imx6q, and maybe others.

+1
