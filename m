From: cyril@ti.com (Cyril Chemparathy)
Date: Wed, 17 Nov 2010 12:54:07 -0500
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <781931.83221.qm@web180301.mail.gq1.yahoo.com>
References: <781931.83221.qm@web180301.mail.gq1.yahoo.com>
Message-ID: <4CE416BF.6000707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2010 10:25 AM, David Brownell wrote:
> 
>> On Tue, Nov 16, 2010 at 07:17:18PM
>> -0500, Cyril Chemparathy wrote:
>>
>>> The ability to wait on multiple devices may come
>> handy.
> 
> ... You mean you'd like to add such a 
> mechanism to the framework? 

Ideally in the framework.  This appears to be a common enough problem
across platforms.

Regards
Cyril.
