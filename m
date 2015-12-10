From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 10 Dec 2015 07:42:07 +0530
Subject: [PATCH v6 00/10] cpufreq: Introduce ST's CPUFreq driver
In-Reply-To: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20151210021207.GC29459@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-12-15, 15:58, Lee Jones wrote:
> This is a re-write of the original submission, hence why the
> change-log is omitted.  Basically almost everything has changed.
> We are now using the new OPP framework and generic bindings
> written by Viresh.
> 
> There are 'ARM' patches in the set which are not necessarily
> related to CPUFreq, but are required to get it to work. Anyone
> who is not interested in general STi DT changes can safely
> ignore these.

Apart from minor comments in the 8th patch, everything else looks
fine.

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
