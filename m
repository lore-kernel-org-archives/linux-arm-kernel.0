From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 21 Mar 2017 15:40:09 +0530
Subject: [PATCH] arm: spear6xx: add labels to various nodes in
 spear600.dtsi
In-Reply-To: <1490090858-8866-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1490090858-8866-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170321101009.GQ25659@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-17, 11:07, Thomas Petazzoni wrote:
> Having labels allows to more easily reference nodes in .dts files
> including spear600.dtsi.

And who is going to use these labels? If you already have some code
using them, then please send that as well. This patch by itself
doesn't provide any benefits.

-- 
viresh
