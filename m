From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 3 Dec 2012 18:53:02 +0530
Subject: [PATCH v3 07/11] ARM: davinci - restructure header files for
 common clock migration
In-Reply-To: <5098362D.1000007@ti.com>
References: <1351181518-11882-1-git-send-email-m-karicheri2@ti.com>
 <1351181518-11882-8-git-send-email-m-karicheri2@ti.com>
 <50967641.4090503@ti.com> <5098362D.1000007@ti.com>
Message-ID: <50BCA7B6.5030807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2012 3:27 AM, Murali Karicheri wrote:
> On 11/04/2012 09:05 AM, Sekhar Nori wrote:

[...]

>> I pushed the patches I fixed to devel-common-clk branch of my git tree.
>> It is build tested using davinci_all_defconfig but its not runtime
>> tested.
>>
>> Can you start from here and provide me incremental changes on top of
>> this? That way we can collaborate to finish this faster.
>>
>> Thanks,
>> Sekhar
>>
> I made a build from your branch and it doesn't boot up DM6446. I will

Okay so there were some silly issues (as expected from untested work)
like not even calling the DM644x common clock initializer function. I
have been able to fix them and now the devel-common-clk branch on my
tree boots on DM644x EVM. The work is still rough and I haven't fixed
many of the comments I gave you before. You can use the updated branch
to base your further work on and once you have something to share,
please put it on a public repo so I can take a look. I will try and
summarize all that I changed in a later mail. Wanted to get this message
out to you as soon as I can.

Thanks,
Sekhar
