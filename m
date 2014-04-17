From: cov@codeaurora.org (Christopher Covington)
Date: Thu, 17 Apr 2014 09:34:52 -0400
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
 <CAFEAcA96XGvwPM=OpqW8EU5nFksiEruGgncwqUPEWeU2ryCoJg@mail.gmail.com>
Message-ID: <534FD87C.4090708@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 06:02 AM, Peter Maydell wrote:
> On 2 April 2014 13:47, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>>> Like others, I have been carrying this change locally. Good to see it up!
>>
>> Why are you all booting raw Images anyway (just out of curiosity)?
> 
> Given the recent feedback from the kernel mailing list (viz "don't boot
> Image unless you really know what you're doing, the correct load
> image may change randomly depending what other board support
> is in a multikernel image, etc") maybe we should just remove the
> Image booting support instead? Clearly nobody who hasn't locally
> patched QEMU is using it at the moment...

An opportunity for a fresh start at low-level loading facilities, should
anyone be inclined to pursue it, sounds good to me.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
