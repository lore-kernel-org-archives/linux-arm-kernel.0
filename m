From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 13 Jul 2012 10:56:53 +0530
Subject: [PATCH 2/8] ARM: OMAP2+: PM: introduce power domains functional
 states
In-Reply-To: <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
References: <1339685591-11177-1-git-send-email-j-pihet@ti.com>
 <1339685591-11177-3-git-send-email-j-pihet@ti.com>
 <CAOMWX4cT+U2iq3e=rfBaSX5Hdn_kNEkdF0ffC33UCuEfEjdisw@mail.gmail.com>
Message-ID: <4FFFB19D.2090808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 July 2012 08:31 AM, Menon, Nishanth wrote:
> my Crib about the above apis are lack of logic power state handling:(
> which forces code like cpuidle to use different apis for logic
> power state and force them to use these apis just for pwrst.

Have you looked at an alternate approach that was proposed here..
https://patchwork.kernel.org/patch/1160431/
