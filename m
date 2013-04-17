From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Apr 2013 15:45:12 +0530
Subject: [PATCH 0/4] ARM: davinci: fix UART clock enabling
In-Reply-To: <A73F36158E33644199EB82C5EC81C7BC3EA4DCC9@DBDE01.ent.ti.com>
References: <1365510481-32129-1-git-send-email-prakash.pm@ti.com>
 <A73F36158E33644199EB82C5EC81C7BC3EA4DCC9@DBDE01.ent.ti.com>
Message-ID: <516E7630.7020906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 4/17/2013 12:02 PM, Manjunathappa, Prakash wrote:
> Hi Sekhar,
> 
> On Tue, Apr 09, 2013 at 17:57:57, Manjunathappa, Prakash wrote:
>> Patch series addresses below issues:
>> 1) Do clk_get on dev_id when there is single clock for a module
>> 2) Fix garbled UART log with DT kernel on da850-evm.
>>
> 
> Could you please accept this series if you do not have review comments?

I have not yet gotten to reviewing this. Its unlikely it will get
reviewed and accepted for v3.10 so this will have to wait for v3.11.

Thanks,
Sekhar
