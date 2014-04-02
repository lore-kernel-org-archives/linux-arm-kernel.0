From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 02 Apr 2014 11:04:21 -0400
Subject: [Qemu-devel] [PATCH] QEMU: ARM: boot: Load kernel at an Image
 friendly address
In-Reply-To: <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
References: <1395718484-20424-1-git-send-email-joelf@ti.com>
 <CAFEAcA9Dc5bN_JdMNWODB9Puj9HLoEBm4mDo7ZcaJj97qBbAdw@mail.gmail.com>
 <CAEgOgz6Tou7aOOKsWO2cOaPjWJrkWBFyU-_bApf+ks=qzSKDdA@mail.gmail.com>
 <CAFEAcA-1hWT69JzSv2zJta_PCCuJ-9fH7muBGPD=u+WOLHmvXQ@mail.gmail.com>
Message-ID: <533C26F5.30302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[On 04/02/2014 08:47 AM, Peter Maydell wrote:
> On 2 April 2014 13:11, Peter Crosthwaite <peter.crosthwaite@xilinx.com> wrote:
>> Like others, I have been carrying this change locally. Good to see it up!
> 
> Why are you all booting raw Images anyway (just out of curiosity)? All my
> test cases boot either a zImage or a uImage, or occasionally a full SD card
> image, or I'd have noticed this earlier...

I do it in part for uniformity with arm64 kernels.

Christopher

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by the Linux Foundation.
