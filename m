From: david.wu@rock-chips.com (David.Wu)
Date: Thu, 23 Feb 2017 20:28:08 +0800
Subject: [PATCH] PM / AVS: rockchip-io: add io selectors and supplies for
 rk3328
In-Reply-To: <43787071.1WOyg3ntUU@phil>
References: <1487556485-18871-1-git-send-email-david.wu@rock-chips.com>
 <43787071.1WOyg3ntUU@phil>
Message-ID: <c49ab15e-052d-aa6f-0ed5-83b1433a469d@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

Sorry not to include your email address in the email list.
And thank Heiko.
I will resend the patch.

? 2017/2/21 23:06, Heiko Stuebner ??:
> Am Montag, 20. Februar 2017, 10:08:05 CET schrieb David Wu:
>> From: "david.wu" <david.wu@rock-chips.com>
>>
>> This adds the necessary data for handling io voltage domains on the rk3328.
>> As interesting tidbit, the rk3328 only contains one iodomain area in the
>> regular General Register Files (GRF).
>>
>> Signed-off-by: david.wu <david.wu@rock-chips.com>
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
> Only issue might be, that you didn't include Rafael (rjw at rjwysocki.net) and
> most of the time io-domain patches go to him directly with an Ack from Kevin,
> as there are normally not enough power/avs patches to warant a pull :-)
>
>
> Heiko
>
>
>
>
