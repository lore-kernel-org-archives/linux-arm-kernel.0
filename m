From: srishtishar@gmail.com (srishti sharma)
Date: Thu, 25 May 2017 10:52:22 +0530
Subject: [PATCH] Staging: bcm2835-audio: bcm2835-ctl.c: Fixed a comment
 coding style issue.
In-Reply-To: <20170524232818.GF2319@eros>
References: <1495636394-2431-1-git-send-email-srishtishar@gmail.com>
 <20170524232818.GF2319@eros>
Message-ID: <CAB3L5oxbhiUUV63aMh+G-6VZb8TgpG=f9d3pYDB0WXCWp5pWPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 4:58 AM, Tobin C. Harding <me@tobin.cc> wrote:
> On Wed, May 24, 2017 at 08:03:14PM +0530, srishti sharma wrote:
>
> This driver is not in Greg KH's staging tree. You may like to work off
> of that tree when doing staging patches.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/
>
> To aid you future patches here are a couple of minor comments for you.
>
>> fixed a trailing */ issue
>
> You may like to be more explicit here using the format described in
> Documentation/process/submitting-patches.rst (Section 2 Describe your
> changes). This goes for your subject line as well.
>
>> Signed-off-by: srishti sharma <srishtishar@gmail.com>
>> ---
>>  drivers/staging/bcm2835-audio/bcm2835-ctl.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/bcm2835-audio/bcm2835-ctl.c b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
>> index a4ffa1b..38fabab 100644
>> --- a/drivers/staging/bcm2835-audio/bcm2835-ctl.c
>> +++ b/drivers/staging/bcm2835-audio/bcm2835-ctl.c
>> @@ -247,8 +247,8 @@ static int snd_bcm2835_spdif_mask_get(struct snd_kcontrol *kcontrol,
>>       struct snd_ctl_elem_value *ucontrol)
>>  {
>>       /* bcm2835 supports only consumer mode and sets all other format flags
>> -      * automatically. So the only thing left is signalling non-audio
>> -      * content */
>> +      * automatically. So the only thing left is signalling non-audio content
>> +      */
>
> And for completeness this is the block comment style in networking
> code, the rest of the kernel uses the format
>
> /*
>  * block comment blah blah
>  * on multiple lines
>  */
>
> Good luck,
> Tobin.




Okay, Thanks a lot .

Regards ,
Srishti
