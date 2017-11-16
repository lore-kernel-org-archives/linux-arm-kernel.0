From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Thu, 16 Nov 2017 11:37:30 +0100
Subject: [linux-sunxi] Cedrus driver
In-Reply-To: <6fcdc0d9-d0f8-785a-bb00-b1b41c684e59@imkreisrum.de>
References: <1510059543-7064-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1b12fa21-bfe6-9ba7-ae1d-8131ac6f4668@micronovasrl.com>
 <6fcdc0d9-d0f8-785a-bb00-b1b41c684e59@imkreisrum.de>
Message-ID: <693e8786-af83-9d77-0fd4-50fa1f6a135f@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 16/11/2017 11:31, Andreas Baierl ha scritto:
> Am 16.11.2017 um 11:13 schrieb Giulio Benetti:
>> Hello,
>>
> Hello,
>> I'm wondering why cedrus 
>> https://github.com/FlorentRevest/linux-sunxi-cedrus has never been 
>> merged with linux-sunxi sunxi-next.
>>
> Because it is not ready to be merged. It depends on the v4l2 request 
> API, which was not merged and which is re-worked atm.
> Also, sunxi-cedrus itself is not in a finished state and is not as 
> feature-complete to be merged. Anyway it might be something for 
> staging... Has there been a [RFC] on the mailing list at all?

Where can I find a list of TODOs to get it ready to be merged?

>> I see it seems to be dead, no commit in 1 year.
> Yes, because the author did this during an internship, which ended ... 
> Afaik nobody picked up his work yet.
>> I would like to respawn it and contribute to sunxi-next,
> Feel free to work on it...

Hope to be able, but I'm going to try.

>> since we need video acceleration on A20 and A33.
>>
> ack.

By the way, when you answer to google group, is it right that all CC I 
inserted are not inserted too?
Because this causes mess with mailing lists (seems to me).

> 
> Regards
> rellla
>> Best regards
>>
> 


-- 
Giulio Benetti
R&D Manager &
Advanced Research

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
