From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 22 Jan 2018 19:12:07 +0100
Subject: ARM-SMMU: Delete error messages for a failed memory allocation in
 three functions
In-Reply-To: <ac171b23-624d-2df3-d1d1-8e9479ae03bc@arm.com>
References: <c3e91414-dd5b-2889-d86c-b19aff56571b@users.sourceforge.net>
 <ac171b23-624d-2df3-d1d1-8e9479ae03bc@arm.com>
Message-ID: <a714a4ab-8118-e4ef-5982-4395ac2e6c4b@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Date: Sat, 20 Jan 2018 15:30:17 +0100
>>
>> Omit extra messages for a memory allocation failure in these functions.
> 
> Why?

Do you find the wording ?WARNING: Possible unnecessary 'out of memory' message?
(from the script ?checkpatch.pl?) more reasonable?


> This may as well be "delete some stuff because I feel like it".

Do you find the Linux allocation failure report insufficient
in this use case?

Regards,
Markus
