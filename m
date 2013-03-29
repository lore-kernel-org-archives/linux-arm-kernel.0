From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 10:02:47 -0600
Subject: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
In-Reply-To: <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <5155BB27.4000405@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 04:31 AM, Daniel Lezcano wrote:
> Initialize the idle states directly in the driver structure.
> 
> That prevents extra structure declaration and memcpy at init time.

Joseph, can you please review/ack patch 5/9 and patch 6/9. Thanks.
