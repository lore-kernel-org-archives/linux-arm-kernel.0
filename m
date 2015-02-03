From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 3 Feb 2015 13:42:02 +0530
Subject: [PATCH v4 2/8] mailbox: arm_mhu: add driver for ARM MHU controller
In-Reply-To: <20150202144622.GD8656@n2100.arm.linux.org.uk>
References: <1421663016-1327-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1421663463-1426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20150202144622.GD8656@n2100.arm.linux.org.uk>
Message-ID: <CAJe_ZhdevMHgoqRM-t+XS4-ZBSMVytG9aZncvH_GeuUT0qc6UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 February 2015 at 20:16, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jan 19, 2015 at 06:31:03PM +0800, Vincent Yang wrote:
>> From: Jassi Brar <jaswinder.singh@linaro.org>
>>
>> Add driver for the ARM Message-Handling-Unit (MHU).
>
> Is this an AMBA Primecell peripheral?  If so, it should not be a platform
> driver.
>
Yes, it is. We have revised the driver and should be part of the
revised patchset to be submitted shortly.

Thank you.
