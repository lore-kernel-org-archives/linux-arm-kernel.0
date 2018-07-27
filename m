From: joel@jms.id.au (Joel Stanley)
Date: Fri, 27 Jul 2018 10:52:24 +0930
Subject: [GIT PULL] ARM: aspeed: dts changes for 4.19
In-Reply-To: <20180726195127.jukxvbydddlwui4k@localhost>
References: <CACPK8Xeu2JAVBTyiUtyso1egbe3X+r5a--Cx30YDJV-JmK==DQ@mail.gmail.com>
 <20180726195127.jukxvbydddlwui4k@localhost>
Message-ID: <CACPK8Xc6qvtooRbMfXO84Uq_90OQ81QjEthMS6DBgtdmYOQpmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27 July 2018 at 05:21, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Thu, Jul 26, 2018 at 02:00:49PM +0930, Joel Stanley wrote:
>> Hello ARM Maintainers,
>>
>> Here are the ASPEED device tree updates for 4.19. No new machines this time
>> around, but we now have some FSI (the bus between the BMC and the PowerPC host)
>> descriptions, and USB support.
>>
>> The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:
>>
>>   Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
>> tags/aspeed-4.19-devicetree
>>
>> for you to fetch changes up to 19617a35b08379b3e6da0a4ee0d2d62645bf1b9e:
>>
>>   ARM: dts: aspeed: Add Power9 CFAM description (2018-07-25 17:43:36 +0930)
>>
>> ----------------------------------------------------------------
>> ASPEED device tree updates for 4.19
>>
>>  - New support for the ASPEED USB host controller and USB vhub (device)
>>  support
>>
>>  - Descriptions for the FSI bus and hardware inside the Power8/Power9
>>  processors that are accessed over this bus. This includes the ColdFire
>>  processor that is part of the ASPEED SoC and is used to offload the FSI
>>  bit-banging
>
> I had some feedback on one of these patches, it should be reworked before we
> merge it. See separate email as reply to the actual patch.
>
> If you prefer, you can send a branch without that contents for merging now, so
> the rest of it isn't held up.

No worries. I have sent a pull request without the FSI changes.

Thanks for taking a close look!

Cheers,

Joel
