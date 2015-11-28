From: frowand.list@gmail.com (Frank Rowand)
Date: Fri, 27 Nov 2015 21:55:31 -0800
Subject: [PATCH 0/5] ATAGs to DT patches
In-Reply-To: <5659282F.8020104@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
 <5659282F.8020104@gmail.com>
Message-ID: <565941D3.3080405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2015 8:06 PM, Frank Rowand wrote:
> On 7/6/2015 1:26 PM, Pali Roh?r wrote:
>> This patch series converts some legacy ATAGs into DT and provide them to
>> userspace. It is needed for userspace applications which needs some
>> informations from legacy bootloaders which are not DT compatible.
>>
>> Patch series is for now without DT documentation files. It was tested in
>> QEMU for Nokia N900. File /proc/cpuinfo contains correct "Revision" line
>> from ATAG_REVISION and /proc/atags contains full ATAGs structure.
> 
> Pali,
> 
> Is this needed just for the N900, or are there other devices that need it?
> If so, which devices?

Nevermind...  I've re-read the earlier threads.

-Frank
