From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 28 Jul 2016 09:18:45 -0700
Subject: [PATCH v3 4/6] usb: core: add power sequence handling for USB
 devices
In-Reply-To: <20160728014521.GB26186@shlinux2>
References: <1469007629-31757-1-git-send-email-peter.chen@nxp.com>
 <1469007629-31757-5-git-send-email-peter.chen@nxp.com>
 <5798E067.90207@gmail.com> <20160728014521.GB26186@shlinux2>
Message-ID: <579A3065.2080402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

On 07/27/2016 06:45 PM, Peter Chen wrote:
> On Wed, Jul 27, 2016 at 09:25:11AM -0700, Joshua Clayton wrote:
>> Patch 4 does not apply for me
>> (The Makefile has  a "usbcore-$(CONFIG_OF) += of.o"
>> line which I don't see in 4.7 or linux/next master).
>> Is there another patch set this series depends on?
> It seems below patch has not been queued:
>
> https://git.kernel.org/cgit/linux/kernel/git/peter.chen/usb.git/commit/?h=add_pwrseq_for_usb&id=2efd73d0f935ffbc66135553da0ac807c0b4c3fe
>
> This pwrseq-lib patch set does not depend on it, I will send patch set
> on top of a clean mainline next time, sorry for confusing. 
>
Good to know.
I just wanted to make sure I wasn't missing something important.

Thanks,

Joshua Clayton
