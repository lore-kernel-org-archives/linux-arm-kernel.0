From: juhosg@openwrt.org (Gabor Juhos)
Date: Fri, 19 Apr 2013 09:19:50 +0200
Subject: [PATCH v7 3/3] of/pci: mips: convert to common of_pci_range_parser
In-Reply-To: <20130418130919.GI27197@titan.lakedaemon.net>
References: <1366107508-12672-1-git-send-email-Andrew.Murray@arm.com>
 <1366107508-12672-4-git-send-email-Andrew.Murray@arm.com>
 <CACRpkdbBaT1OKr5t8HW4+8y_wSDmGxmewAyVMekx8S-K9s3K8Q@mail.gmail.com>
 <20130418125910.GA17128@arm.com>
 <20130418130919.GI27197@titan.lakedaemon.net>
Message-ID: <5170F016.6050502@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013.04.18. 15:09 keltez?ssel, Jason Cooper ?rta:
> On Thu, Apr 18, 2013 at 01:59:10PM +0100, Andrew Murray wrote:
>> On Wed, Apr 17, 2013 at 04:42:48PM +0100, Linus Walleij wrote:
>>> On Tue, Apr 16, 2013 at 12:18 PM, Andrew Murray <Andrew.Murray@arm.com> wrote:
>>>
>>>> This patch converts the pci_load_of_ranges function to use the new common
>>>> of_pci_range_parser.
>>>>
>>>> Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
>>>> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>>>> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Tested-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Jason - you may not have seen this, but here (Linus Walleij) is another Tested-by
>> to add to this patch in your tree (if you can).
> 
> Thanks, I saw it.  Unfortunately, the PR was already sent, and the branch
> is now pulled into arm-soc.

Sorry I had no time earlier, but I have tested this now on MIPS. The patch
causes build errors unfortunately. Given the fact that this has been merged
already, I will send a fixup patch.

-Gabor
