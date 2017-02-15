From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 15 Feb 2017 08:36:01 -0200
Subject: sDMA on i.mx7d
In-Reply-To: <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
References: <20170214222425.hbkfkeq3l6sveo7n@piout.net>
 <e9c36a33f2a49df2a517db5869eaea7f@agner.ch>
Message-ID: <CAOMZO5B+7=JXdaefi9YRBEpe9ktV_oBN0Ogo2DFXUdvuZFvsYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Wed, Feb 15, 2017 at 5:25 AM, Stefan Agner <stefan@agner.ch> wrote:
> Hi Alexandre,
>
> On 2017-02-14 14:24, Alexandre Belloni wrote:
>> Hi,
>>
>> I've been trying to get a PCM3168s codec with a Colibri iMX7 using TDM
>> on SAI2.
>> I've got it working properly with the 4.1.35 kernel from Toradex (based
>> on the 4.1.15 from Freescale).
>> It is working fine with and without providing a firmware to the sDMA.
>>
>> But, I couldn't get that to work with v4.9. I actually managed to
>> reproduce the issue using the SGTL5000 so I don't have any patch on top
>> of v4.9.
>
> I guess you are using the on module SGTL5000 to reproduce?
>
> When I added audio support I remember that the sound seemed to be ok to
> me. Is the corruption such that you can hear it?

I haven't noticed this issue on a warp7 board.

Could you please share your .wav files and reproduction steps?

Thanks
