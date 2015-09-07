From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Sep 2015 11:39:31 +0530
Subject: thermal: mediatek: Add cpu power cooling model
In-Reply-To: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
References: <1441357309-61669-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <20150907060931.GF26760@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04-09-15, 17:01, Dawei Chien wrote:
> Use Intelligent Power Allocation (IPA) technical to add
> static/dynamic power model for binding CPU thermal zone.
> The power allocator governor allocates power budget to control
> CPU temperature.

Sorry but this isn't enough really.. I don't have time to go through
the code and understand the purpose of the series.

Please explain here in detail:
- Why this is needed.
- What/How you are doing it.

(Don't resend, just reply to this email :) )

-- 
viresh
