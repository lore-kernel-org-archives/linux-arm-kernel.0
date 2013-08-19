From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 19 Aug 2013 09:08:34 +0530
Subject: [PATCH 1/9] clk: bcm2835: Fix incorrect placement of __initconst
In-Reply-To: <520903BE.7000705@wwwdotorg.org>
References: <1376298847-21828-1-git-send-email-sachin.kamat@linaro.org>
 <520903BE.7000705@wwwdotorg.org>
Message-ID: <CAK9yfHw8k6e4HhhivXA4gzsnAEr4A0rq_vwSF_52Ljf5C+0NeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 12 August 2013 21:18, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/12/2013 03:13 AM, Sachin Kamat wrote:
>> __initconst should be placed between the variable name and equal
>> sign for the variable to be placed in the intended section.
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>
> I assume Mike will take this through the clk tree.

Please take this series.

-- 
With warm regards,
Sachin
