From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Fri, 27 Jun 2014 10:26:31 +0200
Subject: [PATCH v5 03/14] clk: max77686: Add DT include for MAX77686 PMIC
 clock
In-Reply-To: <53AD22ED.5040303@collabora.co.uk>
References: <1403806546-31122-1-git-send-email-javier.martinez@collabora.co.uk>
 <1403806546-31122-4-git-send-email-javier.martinez@collabora.co.uk>
 <53AD21E5.1030609@suse.de> <53AD22ED.5040303@collabora.co.uk>
Message-ID: <53AD2AB7.1090000@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

Am 27.06.2014 09:53, schrieb Javier Martinez Canillas:
> Hello Andreas,
> 
> On 06/27/2014 09:48 AM, Andreas F?rber wrote:
>> Am 26.06.2014 20:15, schrieb Javier Martinez Canillas:
>>> This patch adds a dt-binding include for Maxim 77686
>>> PMIC clock IDs that can be to be shared between the
>>
>> "can be shared"?
>>
> 
> As it should be quite clear right now I'm not a native English speaker.

Guessed so, me neither. But since it's v5 already and no native speaker
pointed it out, I took the liberty to do so while verifying that the
LD02 typo didn't propagate into your bindings documentation (it didn't).

> I meant
> that the header file can be included by both Device Tree source files and the
> max77802 driver.

AFAIU "clock IDs to be shared" and "clock IDs that can be shared" would
both be valid, but above a verb is missing (e.g., "can be used to").

Thanks for your upstreaming efforts, and don't let me discourage you.

Best regards,

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
