From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Jan 2018 17:20:42 +0100
Subject: [1/3] arm64: defconfig: enable CONFIG_ACPI_APEI_MEMORY_FAILURE
In-Reply-To: <5A621662.1020507@hisilicon.com>
References: <9fdbf03c-1e70-fc45-b218-404294d4bdb1@huawei.com>
 <67045853-42e1-8246-8789-309d1d233659@codeaurora.org>
 <CAK8P3a1qYJ5C=rbFWMEompKMbcJfZKTdkxrOcUs1DSQLA6Th1Q@mail.gmail.com>
 <5A621662.1020507@hisilicon.com>
Message-ID: <CAK8P3a2mS3BNggpw8uNK1tB7au0yFXW0_xV0uKmh-84iMjNmMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 19, 2018 at 5:01 PM, Wei Xu <xuwei5@hisilicon.com> wrote:
> Hi Arnd,
>
> On 2018/1/19 15:06, Arnd Bergmann wrote:
>> On Tue, Jan 16, 2018 at 5:10 PM, Timur Tabi <timur@codeaurora.org> wrote:
>>> On 01/16/2018 09:45 AM, shiju.jose at huawei.com wrote:
>>>>
>>>> Enable ACPI APEI MEMORY FAILURE option for ARM64,
>>>> so that memory errors will be handled.
>>>>
>>>> Signed-off-by: Shiju Jose<shiju.jose@huawei.com>
>>>
>>>
>>> All three patches:
>>>
>>> Acked-by: Timur Tabi <timur@codeaurora.org>
>>>
>>> QDT definitely would like to see these patches merged into 4.16.
>>
>> Applied all three to next/soc with your ack, thanks!
>>
>> Shiju, there was a small problem with the second patch, which did not
>> apply cleanly, but I fixed it up. It might have been easier to get a pull
>> request through Wei Xu for this, and it would also help to send things
>> a lot earlier rather than just before the merge window.
>
> Thank you so much!
> I planned to pick up them after 4.16-rc1
> since it is too close to the merge window.

That would have been ok, too, of course. I mainly picked them up as they
look trivial and harmless, and Timur also weighed in here. I don't see
exactly how they ended up in my arm-soc mail folder, I assumed that
they had been addressed to:arm at kernel.org, but that doesn't actually
appear to be the case ;-)

        Arnd
