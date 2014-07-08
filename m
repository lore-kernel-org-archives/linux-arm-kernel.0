From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Tue, 8 Jul 2014 14:22:24 +0530
Subject: [PATCH v5 3/3] clk: samsung: exynos5420: Setup clocks before
 system suspend
In-Reply-To: <53BBAF1B.9080309@gmail.com>
References: <1403781135-6538-1-git-send-email-vikas.sajjan@samsung.com>
 <1403781135-6538-4-git-send-email-vikas.sajjan@samsung.com>
 <53B1A562.6000300@samsung.com>
 <CAGm_ybgLdPrXX-kZJdTeFZxxNZ-Ehtn7M3JxYb0ZYfDZnfszUw@mail.gmail.com>
 <53BBAF1B.9080309@gmail.com>
Message-ID: <CAGm_ybgg+CTPLrPNepLdZwDcpevKPU_qgSyhvAFXLPiiGmM22Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 2:13 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Vikas,
>
> On 08.07.2014 06:34, Vikas Sajjan wrote:
>> Hi Kukjin,
>>
>> On Mon, Jun 30, 2014 at 11:28 PM, Tomasz Figa <t.figa@samsung.com> wrote:
>>> Hi Vikas, Abhilash,
>>>
>>> On 26.06.2014 13:12, Vikas Sajjan wrote:
>>>> Prior to suspending the system, we need to ensure that certain
>>>> clock source and gate registers are unmasked.
>>>>
>>>> while at it, add these clks to save/restore list also.
>>>>
>>>> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
>>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>>> ---
>>>>  drivers/clk/samsung/clk-exynos5420.c |   29 +++++++++++++++++++++++++++++
>>>>  1 file changed, 29 insertions(+)
>>>
>>> Looks good. Will apply.
>>>
>>
>> Can you apply this patch.
>
> As I said, I will take this through the samsung-clk tree. The patch
> should appear there soon.


OK, Thanks.


>
> Best regards,
> Tomasz
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
