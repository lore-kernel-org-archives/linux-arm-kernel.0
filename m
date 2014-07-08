From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Tue, 8 Jul 2014 10:04:31 +0530
Subject: [PATCH v5 3/3] clk: samsung: exynos5420: Setup clocks before
 system suspend
In-Reply-To: <53B1A562.6000300@samsung.com>
References: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>
 <1403781135-6538-4-git-send-email-vikas.sajjan@samsung.com>
 <53B1A562.6000300@samsung.com>
Message-ID: <CAGm_ybgLdPrXX-kZJdTeFZxxNZ-Ehtn7M3JxYb0ZYfDZnfszUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Mon, Jun 30, 2014 at 11:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> Hi Vikas, Abhilash,
>
> On 26.06.2014 13:12, Vikas Sajjan wrote:
>> Prior to suspending the system, we need to ensure that certain
>> clock source and gate registers are unmasked.
>>
>> while at it, add these clks to save/restore list also.
>>
>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5420.c |   29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>
> Looks good. Will apply.
>

Can you apply this patch.


> Best regards,
> Tomasz
