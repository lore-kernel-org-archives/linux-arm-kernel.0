From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 9 Aug 2013 11:02:15 +0530
Subject: [PATCH 1/3] clk: tegra114: Fix incorrect placement of __initdata
In-Reply-To: <5203E097.1040502@wwwdotorg.org>
References: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
 <5203E097.1040502@wwwdotorg.org>
Message-ID: <CAK9yfHyOsnSvE65hpcJUZW4yapf3NZMLs9vS=YFR=Nh8Z8TF=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2013 23:46, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/07/2013 10:25 PM, Sachin Kamat wrote:
>> __initdata should be placed between the variable name and equal
>> sign for the variable to be placed in the intended section.
>
> The series,
> Acked-by: Stephen Warren <swarren@nvidia.com>
>
> Patch 1,
> Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks Stephen.


-- 
With warm regards,
Sachin
