From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon, 30 Oct 2017 08:29:36 -0700
Subject: [GIT PULL 1/3] ARM: Keystone DTS update for 4.15
In-Reply-To: <CAK8P3a2-2JeTgkd+H9Oth-e03sVFtjJWFX8=eSF4TddCGW4GUQ@mail.gmail.com>
References: <1508548966-7350-1-git-send-email-santosh.shilimkar@oracle.com>
 <CAK8P3a2-2JeTgkd+H9Oth-e03sVFtjJWFX8=eSF4TddCGW4GUQ@mail.gmail.com>
Message-ID: <f5f3ec53-1124-5914-2746-c0aa3a082447@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2017 5:18 AM, Arnd Bergmann wrote:
> On Sat, Oct 21, 2017 at 3:22 AM, Santosh Shilimkar
> <santosh.shilimkar@oracle.com> wrote:
>> ----------------------------------------------------------------
>> ARM: Keystone DTS update for 4.15
>>
>> - McASP support for K2G EVM
>> - I2C support for K2G EVM
>> - USB support for K2G EVM
>> - SPI & SPI NOR flash support for K2G EVM
>> - ECAP PWM support for K2G EVM
> 
> Pulled into next/dt, I had a small conflict against Rob's 'drop
> leading zeroes in
> node unit-addresses' patch, and noticed that the new McASP nodes introduced
> additional leading zeroes. I've removed those in the merge.
> 
Thanks Arnd !!

Regards,
Santosh
