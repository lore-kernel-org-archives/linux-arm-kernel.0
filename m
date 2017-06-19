From: aravind.thk@gmail.com (Aravind Thokala)
Date: Mon, 19 Jun 2017 23:15:27 +0530
Subject: [PATCH] mips: bcm63xx: spi: Fix checkpatch.pl warnings
In-Reply-To: <2d01bbe8-33bd-9aea-8906-0fe54bb2c334@gmail.com>
References: <1497890980-4334-1-git-send-email-aravind.thk@gmail.com>
 <2d01bbe8-33bd-9aea-8906-0fe54bb2c334@gmail.com>
Message-ID: <CAAUiYHd8TrD7HuLU9SpmSXUB-Aph8qToCkDBpqWyqks2fwnF7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

On 19 June 2017 at 22:51, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 06/19/2017 09:49 AM, Aravind Thokala wrote:
>> This patch fixes the checkpatch.pl warnings on the driver
>> file.
>>
>> Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
>
> The subject should be spi/bcm63xx: Fix checkpatch warnings to be
> consistent with previous submissions done to that file.

Thanks, I will send v2 patch with the change in subject.

>
> With that:
>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thank you for reviewing the patch.

Aravind.

>
>> ---
>>  drivers/spi/spi-bcm63xx.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
>> index 247f71b..84c7356 100644
>> --- a/drivers/spi/spi-bcm63xx.c
>> +++ b/drivers/spi/spi-bcm63xx.c
>> @@ -147,7 +147,7 @@ struct bcm63xx_spi {
>>
>>       /* Platform data */
>>       const unsigned long     *reg_offsets;
>> -     unsigned                fifo_size;
>> +     unsigned int            fifo_size;
>>       unsigned int            msg_type_shift;
>>       unsigned int            msg_ctl_width;
>>
>> @@ -191,7 +191,7 @@ static inline void bcm_spi_writew(struct bcm63xx_spi *bs,
>>  #endif
>>  }
>>
>> -static const unsigned bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
>> +static const unsigned int bcm63xx_spi_freq_table[SPI_CLK_MASK][2] = {
>>       { 20000000, SPI_CLK_20MHZ },
>>       { 12500000, SPI_CLK_12_50MHZ },
>>       {  6250000, SPI_CLK_6_250MHZ },
>>
>
>
> --
> Florian
