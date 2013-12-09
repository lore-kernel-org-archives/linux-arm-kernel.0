From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 9 Dec 2013 13:36:09 +0530
Subject: [PATCH 5/7] clk/samsung: add support for pll2550xx
In-Reply-To: <1386345391-23482-6-git-send-email-rahul.sharma@samsung.com>
References: <1386345391-23482-1-git-send-email-rahul.sharma@samsung.com>
 <1386345391-23482-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAK9yfHybjunOjcaBd-k2ibfEW2wNFb=Rd+ZbLBO2DAfha9mZSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On 6 December 2013 21:26, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Pankaj Dubey <pankaj.dubey@samsung.com>
>
> exynos5260 use pll2520xx and it has different bitfields
> for P,M,S values as compared to pll2550xx. Support for
> pll2520xx is added here.

This is a bit confusing to me. The commit message says "Support for
pll2520xx is added". However, the patch subject and the entire code looks to
be adding support for 2550xx.


-- 
With warm regards,
Sachin
