From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon, 11 Nov 2013 21:09:34 +0530
Subject: [PATCH v5 1/7] gpio: davinci: remove unnecessary printk
In-Reply-To: <527D05BA.3000008@ti.com>
References: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
 <1383905510-31760-2-git-send-email-prabhakar.csengg@gmail.com>
 <527D05BA.3000008@ti.com>
Message-ID: <CA+V-a8tD0NVEij6qXZ6iYe96QwpvTKjcmdBv0S4qzwRkCzDtjw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grygorii,

Thanks for the review.

On Fri, Nov 8, 2013 at 9:09 PM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> On 11/08/2013 12:11 PM, Prabhakar Lad wrote:
>>
>> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>>
>> the devm_*() helper prints error messages in case of
>> errors no need to do the same in the driver.
>
>
> Pls, drop it - devm_clk_get() doesn't always print error messages
>
OK will drop in the next version.

Regards,
--Prabhakar Lad
