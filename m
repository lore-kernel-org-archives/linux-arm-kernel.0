From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 26 Feb 2018 17:10:59 +0000
Subject: [PATCH v6 03/20] firmware: arm_scmi: add basic driver
 infrastructure for SCMI
In-Reply-To: <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
References: <1519403030-21189-1-git-send-email-sudeep.holla@arm.com>
 <1519403030-21189-4-git-send-email-sudeep.holla@arm.com>
 <CAOFm3uE8q63h-zk3FGnZkDqvxjJj=d0mfuUtK+nyioKosmt=dw@mail.gmail.com>
Message-ID: <9c173e91-cb4e-fcc4-7671-b16c0a672401@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On 26/02/18 15:57, Philippe Ombredanne wrote:
> Sudeep,

[...]

>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/common.h
>> @@ -0,0 +1,77 @@
>> +/*
>> + * System Control and Management Interface (SCMI) Message Protocol
>> + * driver common header file containing some definitions, structures
>> + * and function prototypes used in all the different SCMI protocols.
>> + *
>> + * Copyright (C) 2017 ARM Ltd.
>> + *
>> + * This program is free software; you can redistribute it and/or modify it
>> + * under the terms and conditions of the GNU General Public License,
>> + * version 2, as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope it will be useful, but WITHOUT
>> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
>> + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
>> + * more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
> 
> Would you consider using the SPDX tags [1] instead of this legalese?
> Thanks!
> 

Sure, I have fixed locally [1] for now, will post if there are any other
changes before PR.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-list/new_arm_scmi
