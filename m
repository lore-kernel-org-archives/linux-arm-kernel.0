From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 8 Oct 2016 12:26:05 +0200
Subject: [PATCH 1/3] nvmem: add NXP LPC18xx OTP driver
In-Reply-To: <8ad4d5fb-0672-fbd7-6076-a91c89dee132@mleia.com>
References: <20160913161241.22492-1-manabian@gmail.com>
 <20160913161241.22492-2-manabian@gmail.com>
 <8ad4d5fb-0672-fbd7-6076-a91c89dee132@mleia.com>
Message-ID: <CAGhQ9VytKvCK9ViHLqmc6wCeOh0RsmB3n87zNDTOMLkE5-9arw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On 7 October 2016 at 03:44, Vladimir Zapolskiy <vz@mleia.com> wrote:
> Hi Joachim, Srinivas,
>
> On 13.09.2016 19:12, Joachim Eastwood wrote:
>> Add simple read only driver for the internal OTP (One Time Programmable)
>> memory found on all NXP LPC18xx and LPC43xx devices.
>>
>> The OTP memory is split into 4 banks each with 4 32-bits word. Some of
>> the banks contain predefined data while others are for general purpose
>> and user programmable via the OTP API in ROM. Note that writing to the
>> OTP memory is not yet supported.
>>
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>
> please feel free to add my
>
>   Tested-by: Vladimir Zapolskiy <vz@mleia.com>

Thanks for testing!


regards,
Joachim Eastwood
