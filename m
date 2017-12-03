From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sat, 2 Dec 2017 20:00:26 -0800
Subject: [PATCH] ARM: dts: keystone-k2l: Add the second gpio bank node
In-Reply-To: <61c80992-92bd-a401-457c-267c64a3400d@oracle.com>
References: <1510227778-20491-1-git-send-email-j-keerthy@ti.com>
 <61c80992-92bd-a401-457c-267c64a3400d@oracle.com>
Message-ID: <0075084d-5b1a-b0c1-1c23-41aef3ff0fd5@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/13/17 9:12 AM, Santosh Shilimkar wrote:
> On 11/9/2017 3:42 AM, Keerthy wrote:
>> In case of k2l there are 2 more banks with 16 pins each.
>> Adding the node as the da-vinci driver now supports multiple
>> banks.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
>>
>> This is based on linux-next branch. Boot tested on keystone-k2l-evm.
>>
> Will pick this up Keerthy !!
> 
Applied
