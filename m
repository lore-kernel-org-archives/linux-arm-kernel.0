From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 14:46:19 -0700
Subject: [PATCH v3 09/10] DT: QCOM: Add cpufreq-dt to msm8996
In-Reply-To: <017c01d3c08a$cf903270$6eb09750$@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-10-git-send-email-ilialin@codeaurora.org>
 <152147812199.242365.11821734771337881765@swboyd.mtv.corp.google.com>
 <013a01d3c051$d65a9160$830fb420$@codeaurora.org>
 <152157637794.125118.12382168941652366593@swboyd.mtv.corp.google.com>
 <017c01d3c08a$cf903270$6eb09750$@codeaurora.org>
Message-ID: <152158237920.125118.18071859696919294995@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilialin at codeaurora.org (2018-03-20 13:34:04)
> Understood, what you mean. I assumed that the cpufreq-dt is generic driver, and adding architecture specific code to it is no not correct from architectural point of view. Anyway, I'm considering adding a platform specific cpufreq driver, which will handle the efuse data as well.
> 
> Meanwhile this is the way to use the generic driver.
> 

You'll need to Cc Viresh Kumar, who can comment further on cpufreq-dt.
I wasn't recommending adding architecture specific code to cpufreq-dt,
but at least updating how it handles CPU clk on/off state around hotplug
would be good to do.
