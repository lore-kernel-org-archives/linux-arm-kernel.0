From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 02:55:02 -0400
Subject: [RFC PATCH for Juno 0/2] Drivers for Juno to boot from ACPI
In-Reply-To: <353732273.2TKdyNJ83M@wuerfel>
References: <1409583961-7466-1-git-send-email-hanjun.guo@linaro.org>
 <353732273.2TKdyNJ83M@wuerfel>
Message-ID: <540EA446.7010200@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 11:29 AM, Arnd Bergmann wrote:
> On Monday 01 September 2014 23:05:59 Hanjun Guo wrote:
>> This patch set is example of the sort of driver changes needed to boot
>> Juno using ACPI tables, which using the ACPI tables devloped for MS
>> Windows and published by ARM [1].
> 
> What about platform support?

I think Juno is just serving as an example here since it's from ARM and
thus various people have access to it already, etc. It's not the best
example of a server platform out there, since that wasn't its original
design purpose (but it's a wonderful platform nonetheless). There is
work currently in flight to offer other reference ACPI examples.

Jon.
