From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 21 Mar 2017 11:17:36 +0100
Subject: [PATCH] arm: spear6xx: add labels to various nodes in
 spear600.dtsi
In-Reply-To: <20170321101009.GQ25659@vireshk-i7>
References: <1490090858-8866-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170321101009.GQ25659@vireshk-i7>
Message-ID: <20170321111736.276ae093@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks for the quick feedback!

On Tue, 21 Mar 2017 15:40:09 +0530, Viresh Kumar wrote:

> And who is going to use these labels? If you already have some code
> using them, then please send that as well. This patch by itself
> doesn't provide any benefits.

I'm using it for a custom platform that doesn't make sense to upstream
the support for.

However, if you would like them to be used mainline, I can send a patch
that updates spear600-evb.dts to use those labels. Would this make
sense?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
