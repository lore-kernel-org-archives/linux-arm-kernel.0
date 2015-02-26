From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Thu, 26 Feb 2015 00:36:05 +0000
Subject: [PATCH v5 3/4] media: ov2640: add primary dt support
In-Reply-To: <54ED4772.902@atmel.com>
References: <1423560696-12304-1-git-send-email-josh.wu@atmel.com>
 <1423560696-12304-4-git-send-email-josh.wu@atmel.com>
 <CA+V-a8vkd2Q714s=o9WZZvPWJQATp=6POb8VYdSgarKxxEKqyQ@mail.gmail.com>
 <54ED4772.902@atmel.com>
Message-ID: <CA+V-a8s_PosECku7Pzg4Rt4Mq7_mMtvo3ZGDxUByx__XEgUxcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Wed, Feb 25, 2015 at 3:54 AM, Josh Wu <josh.wu@atmel.com> wrote:
> Hi, Prabhakar Lad
>
>
> On 2/17/2015 12:48 AM, Lad, Prabhakar wrote:
>>
>> Hi Josh,
>>
>> Thanks for the patch.
>>
>> On Tue, Feb 10, 2015 at 9:31 AM, Josh Wu <josh.wu@atmel.com> wrote:
>> [Snip]
>>>
>>> -       priv->clk = v4l2_clk_get(&client->dev, "mclk");
>>> +       priv->clk = v4l2_clk_get(&client->dev, "xvclk");
>>
>> with this change don?t you need to update the board file using this
>> driver/
>> the bridge driver ?
>
> I think no.
>
> First, my patch should be on top of the following two patches, which changed
> the *v4l2_clk_get()* behavior:
> [v3,1/2] V4L: remove clock name from v4l2_clk API
> https://patchwork.linuxtv.org/patch/28108/
> [v4,2/2] V4L: add CCF support to the v4l2_clk API
> https://patchwork.linuxtv.org/patch/28111/
>
Thanks I missed the dependent patches.

Cheers,
--Prabhakar Lad
