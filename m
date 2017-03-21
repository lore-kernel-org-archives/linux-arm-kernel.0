From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 21 Mar 2017 16:29:43 +0530
Subject: [PATCH v2 0/5] arm: spear6xx: DT cleanups and improvements
In-Reply-To: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1490093512-32665-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170321105943.GT25659@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-17, 11:51, Thomas Petazzoni wrote:
> Hello,
> 
> This small series brings a few minor DT cleanups and improvements for
> the SPEAr600 platform:
> 
>  - Provide and use DT node labels
>  - Fix minor coding style issue
>  - Switch to the new MTD partition DT binding
>  - Remove unneeded pinctrl properties
> 
> Changes since v1:
> 
>  - Add a few more node labels, and convert the spear600-evb.dts to use
>    node labels, so that one platform upstream uses the node labels.
> 
>  - Add more patches making misc cleanups/improvements in
>    spear600-evb.dts.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
