From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 5 Jun 2012 10:03:30 +0800
Subject: [PATCH v2 8/9] ARM: dts: refresh dts file for arch mmp
In-Reply-To: <87d35ezkm1.fsf@laptop.org>
References: <1336134626-12262-1-git-send-email-haojian.zhuang@gmail.com>
 <1336134626-12262-9-git-send-email-haojian.zhuang@gmail.com>
 <87d35ezkm1.fsf@laptop.org>
Message-ID: <CAN1soZx2Gj=ZggFjekTU4CNYeDn40wH2tdGmEDv9W8S32rXRXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 5, 2012 at 8:08 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Haojian,
>
> On Fri, May 04 2012, Haojian Zhuang wrote:
>> Append mmp2 and pxa910 dts files. Update PXA168 dts files for irq,
>> timer, gpio components.
>
> The patch I'm replying to introduced a device tree for MMP2/Brownstone
> in 3.5-rc1. ?We're looking at adopting the MMP2 device tree for the OLPC
> XO-1.75 board, and Mitch Bradley has some corrections to the device tree
> format that we'd like to make, appended below.
>
> You can see all of the files Mitch mentions at:
> http://dev.laptop.org/~wmb/mmp2-devicetree/
>
> Here's my proposal for what to do next:
> ?* First, you choose one of the two forms that Mitch links to.
> ? (Either "mmp2.dtsi" or "mmp2-flat.dtsi"; we have a weak preference
> ? for mmp2-flat.dtsi.)
> ?* Then we'll post patches that modify the arch code to handle the new
> ? DT format, and ask for your testing and ACK.
> ?* We can try to merge the modified .dts files and .c code to 3.5/3.6.
> ?* We'll work on merging XO-1.75 support into mainline and adding DT
> ? support for new devices, too.
>
> What do you think?
>
I think that mmp2-flat.dtsi is better. We can use this. Thanks for your effort.

Regards
Haojian
> Thanks,
>
> - Chris.
>
