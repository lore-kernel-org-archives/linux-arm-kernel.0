From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Feb 2016 07:06:28 +0530
Subject: Crashes in arm qemu emulations due to 'cpufreq: governor:
 Replace timers with utilization ...'
In-Reply-To: <6826860.yxabWEoz5T@vostro.rjw.lan>
References: <20160215170527.GA24453@roeck-us.net>
 <CAJZ5v0gLankSuziQq25qTCyNqeOX43yD9jnJu_XXwbdyajfmKg@mail.gmail.com>
 <20160216011335.GI6334@vireshk-i7>
 <6826860.yxabWEoz5T@vostro.rjw.lan>
Message-ID: <20160216013628.GK6334@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16-02-16, 02:27, Rafael J. Wysocki wrote:
> Yes, that's what we should be doing, but it seemed to me that we didn't.
> 
> Or maybe the trace just contained the last one, because that's when the
> crash happened.

Ofcourse, it wouldn't mention the function calls that have already
finished :)

-- 
viresh
