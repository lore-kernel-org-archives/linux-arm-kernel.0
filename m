From: csd@broadcom.com (Christian Daudt)
Date: Wed, 18 Sep 2013 15:53:35 -0700
Subject: [PATCH 06/22] ARM: dts: bcm281xx: Remove '0x's from
 BCM11351 DTS file
In-Reply-To: <20130812135439.GF13851@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-6-git-send-email-lee.jones@linaro.org>
 <51EDAC90.6010108@broadcom.com> <20130723075309.GE26801@laptop>
 <CAGFynZ-+UoML32ecX4nSGAaFJXqQpdq+D8j7GqJSKhxsE7w=9A@mail.gmail.com>
 <20130812135439.GF13851@lee--X1>
Message-ID: <523A2EEF.3070406@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-08-12 06:54 AM, Lee Jones wrote:
> On Thu, 08 Aug 2013, Christian Daudt wrote:
>
>> Hi Lee,
>>   I had to change some of the lines in the dts files you modified, so
>> I've added your mods. This patch:
>> https://lkml.org/lkml/2013/8/8/477
>>
>> includes your changes to bcm11351.dtsi and bcm11351-brt.dts. Not sure
>> where your patch is at this point, but I just wanted to point that
>> out.
> I haven't done anything with that patch yet, but I'd prefer they
> stayed separate to be honest. If you make your changes and ensure
> they're in an upstream tree (and let me know which one), I'll rebase
> my patches on top of that tree.

These changes are in 3.12-rc1 now:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d7358f845645c588aff84ac6b476a17d3eec75fa


  thanks,
    csd
