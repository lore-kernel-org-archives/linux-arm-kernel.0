From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Jun 2018 09:01:15 -0300
Subject: [PATCH v1] ARM: imx: add imx7d-m4
In-Reply-To: <3fa291a7da6978545cd21fdcf78c483e@agner.ch>
References: <20180405115134.8036-1-o.rempel@pengutronix.de>
 <93e7b7ef-1bc0-2871-da2c-65ab3f070c07@pengutronix.de>
 <20180611082022.GG16091@dragon>
 <1528706126.2842.1.camel@pengutronix.de>
 <3fa291a7da6978545cd21fdcf78c483e@agner.ch>
Message-ID: <CAOMZO5CDqioBvQb919FZ79NUGBBB0gWgaMe0ueUu1BUxZS7D6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 11, 2018 at 8:48 AM, Stefan Agner <stefan@agner.ch> wrote:
> On 11.06.2018 10:35, Lucas Stach wrote:
>> Hi Shawn,
>>
>> Am Montag, den 11.06.2018, 16:20 +0800 schrieb Shawn Guo:
>>> On Mon, Jun 11, 2018 at 10:02:53AM +0200, Oleksij Rempel wrote:
>>> > Hi all,
>>> >
>>> > this patch was send 05.04.2018. Any comments?
>>> >
>>> > @Shawn, can you please take it?
>>>
>>> Honestly I'm not sure how useful it will be.  If we can have some i.MX
>>> developers ACK on it, I will be more comfortable to take it.
>>
>> This is all highly experimental and in PoC stage, but we see some value
>> in running a second Linux system on the M4 coprocessor. There are lots
>> of things that still need to be figured out, but we are working on this
>> from time to time when there are some hours to spare.
>>
>> This patch seems like a good step in the right direction and IMHO the
>> amount of code and changes is small enough to carry it upstream without
>> impacting anything else. I would be happy if this could be pulled in.
>
> I agree with Lucas here, this is rather minimal and not invasive.

Agreed here as well.

It would be nice if we could start improving the CortexM4 support in
general with mainline.

Thanks
