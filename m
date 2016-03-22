From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 22 Mar 2016 14:45:57 -0700
Subject: [PATCH v15 0/6] arm64, numa: Add numa support for arm64 platforms
In-Reply-To: <56F1936E.1090407@redhat.com>
References: <1457481587-8976-1-git-send-email-ddaney.cavm@gmail.com>
 <56F1936E.1090407@redhat.com>
Message-ID: <56F1BD15.4000701@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2016 11:48 AM, Jon Masters wrote:
> On 03/08/2016 06:59 PM, David Daney wrote:
>
>> From: David Daney <david.daney@cavium.com>
>>
>> v15:
>>
>> 	- Make the distance-map node optional (again), if it is not in
>>            the device tree, default values are used.
>>
>> 	- Minor cleanups to of_numa.c as suggested by Rob Harring.
>
> Hi David, all,
>
> Wondering what the status of this patch series is currently?

I haven't seen any feedback on v15.  My assumption was that the relevant 
arm64 maintainers would take some sort of action after the merge window 
quiets down.

In any event, I am happy to make any improvements that may be suggested.

David Daney
