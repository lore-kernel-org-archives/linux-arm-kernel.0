From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 08 Jul 2014 10:43:07 +0200
Subject: [PATCH v5 3/3] clk: samsung: exynos5420: Setup clocks before
 system suspend
In-Reply-To: <CAGm_ybgLdPrXX-kZJdTeFZxxNZ-Ehtn7M3JxYb0ZYfDZnfszUw@mail.gmail.com>
References: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>	<1403781135-6538-4-git-send-email-vikas.sajjan@samsung.com>	<53B1A562.6000300@samsung.com>
 <CAGm_ybgLdPrXX-kZJdTeFZxxNZ-Ehtn7M3JxYb0ZYfDZnfszUw@mail.gmail.com>
Message-ID: <53BBAF1B.9080309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vikas,

On 08.07.2014 06:34, Vikas Sajjan wrote:
> Hi Kukjin,
> 
> On Mon, Jun 30, 2014 at 11:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>> Hi Vikas, Abhilash,
>>
>> On 26.06.2014 13:12, Vikas Sajjan wrote:
>>> Prior to suspending the system, we need to ensure that certain
>>> clock source and gate registers are unmasked.
>>>
>>> while at it, add these clks to save/restore list also.
>>>
>>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> ---
>>>  drivers/clk/samsung/clk-exynos5420.c |   29 +++++++++++++++++++++++++++++
>>>  1 file changed, 29 insertions(+)
>>
>> Looks good. Will apply.
>>
> 
> Can you apply this patch.

As I said, I will take this through the samsung-clk tree. The patch
should appear there soon.

Best regards,
Tomasz
