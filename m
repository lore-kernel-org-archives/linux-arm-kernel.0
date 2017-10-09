From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Mon, 9 Oct 2017 13:51:00 +0800
Subject: [PATCH ] cpufreq: ti-cpufreq: kfree opp_data when failure
In-Reply-To: <20171004053642.GA8478@vireshk-i7>
References: <1506496097-30852-1-git-send-email-zumeng.chen@windriver.com>
 <20170927174026.GB12211@ubuntu>
 <7b7315f0-c2e4-a09e-8769-2d15a167fa73@windriver.com>
 <20170928041933.GG12211@ubuntu>
 <7a2171a3-d594-7fd7-2ccf-75ef7110dd98@windriver.com>
 <20171004053642.GA8478@vireshk-i7>
Message-ID: <5dbd2161-1cef-01c4-ac3a-19fcd4cc19f7@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2017 01:36 PM, Viresh Kumar wrote:
> On 28-09-17, 13:00, Zumeng Chen wrote:
>> Yes, you are right, it seems of_node_put(np) that you mentioned were
>> ignored by both paths. If you don't mind I can deliver a separate patch
>> to fix this based on some testing later.
> Yeah, that's exactly how I want it.
>
OK,  I'll do it when I'm back from vacation, thanks ~
