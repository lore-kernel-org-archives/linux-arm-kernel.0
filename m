From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 7 Feb 2016 17:52:12 +0530
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <3308645.nrPBoahQ2V@wuerfel>
References: <56B4D4BE.2040008@free.fr>
 <3308645.nrPBoahQ2V@wuerfel>
Message-ID: <20160207122212.GA3808@vireshk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05-02-16, 23:24, Arnd Bergmann wrote:
> We no longer call platform_device_register_simple() from platform code, at least
> for new platforms, and we should probably remove the code from the existing
> platforms that still do it. I forget what the replacement was, but I'm not
> going to take this version. Viresh should be able to help you do it the right
> way.

We thought initially that opp-v2's compatible string can be used to probe the
drivers, but that was denied later and all we do today is add platform devices
for cpufreq.

What do you have in mind Arnd ?

-- 
viresh
