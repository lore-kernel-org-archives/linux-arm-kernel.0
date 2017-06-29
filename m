From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jun 2017 17:20:36 +0200
Subject: [GIT PULL] ARM: actions: arm64 for v4.13
In-Reply-To: <CAK8P3a3vB9J5nDWB5TU54Xxa9upc61iKtxcoSYagyMMAyn-WkA@mail.gmail.com>
References: <20170623172556.12618-1-afaerber@suse.de>
 <20170623172556.12618-3-afaerber@suse.de>
 <CAK8P3a3vB9J5nDWB5TU54Xxa9upc61iKtxcoSYagyMMAyn-WkA@mail.gmail.com>
Message-ID: <CAK8P3a1OX-wLD1pxyUo7s3KcBws13Gzvsghtv+uAXkqQdpZjfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 29, 2017 at 5:18 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 23, 2017 at 7:25 PM, Andreas F?rber <afaerber@suse.de> wrote:
>>
>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>
>>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm64-soc-for-4.13
>>
>> for you to fetch changes up to c88cc3ee1b2045ccff904f1187d62fdc3895a532:
>>
>>   arm64: Prepare Actions Semi S900 (2017-06-19 03:14:48 +0200)
>>
>> ----------------------------------------------------------------
>> Actions Semi ARM64 SoC for v4.13
>>
>> This adds a Kconfig symbol for DTs and drivers being added.
>>
>
> Pulled into next/dt64, thanks,

Sorry, replied to the wrong mail at first. I merged you
actions-arm64-dt branch into
next/dt64 earlier, and have now merged this one into next/arm64.

       Arnd
