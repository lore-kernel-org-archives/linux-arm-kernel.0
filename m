From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 29 Mar 2016 13:27:43 -0700
Subject: [PATCH 3/4] arm64: dts: Move NS2 clock DT nodes to separate DT
 file
In-Reply-To: <CAGt4E5vadj_Z8tqapA02z6hHkztM5YgLU4Sv-EYeR-ohk2Jkgg@mail.gmail.com>
References: <1459236454-26285-1-git-send-email-anup.patel@broadcom.com>
 <1459236454-26285-4-git-send-email-anup.patel@broadcom.com>
 <CAGt4E5vadj_Z8tqapA02z6hHkztM5YgLU4Sv-EYeR-ohk2Jkgg@mail.gmail.com>
Message-ID: <2FCC19A3-B758-4150-B9A1-FCAD968E7165@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On March 29, 2016 11:47:10 AM PDT, Markus Mayer <markus.mayer@broadcom.com> wrote:
>> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> index 940ed52..0a92a68 100644
>> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
>> @@ -1,7 +1,7 @@
>>  /*
>>   *  BSD LICENSE
>>   *
>> - *  Copyright(c) 2015 Broadcom Corporation.  All rights reserved.
>> + *  Copyright (c) 2015 Broadcom.  All rights reserved.
>
>I am thinking the 2015 copyright notice should remain as is and a new
>2016 notice should be added underneath.
>
>Copyright (c) 2016 Broadcom.  All rights reserved.

IANAL, but the directions given by our management on how to deal with these were clear, and they mentioned the use of Broadcom as holder name here irrespective of the time frame.

-- 
Florian
