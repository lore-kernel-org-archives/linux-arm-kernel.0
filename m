From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 1 Oct 2018 15:17:28 +0200
Subject: [PATCH v3 2/4] firmware: xilinx: Add zynqmp IOCTL API for device
 control
In-Reply-To: <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
References: <1537985581-32164-1-git-send-email-jollys@xilinx.com>
 <1537985581-32164-3-git-send-email-jollys@xilinx.com>
 <CAOesGMhEcMB4caAPtCSq-m5zQBDc-8Z4f_xAkomnEwVaHyX2Mw@mail.gmail.com>
 <BL2PR02MB21308D0B6AF76A8094E70863B8EC0@BL2PR02MB2130.namprd02.prod.outlook.com>
 <CAOesGMiUnVrnW1VDh1CKRKGpkwAC9G8tiHjpb+7bss6LpPWU-A@mail.gmail.com>
Message-ID: <2350f5c3-b59e-b37b-c679-5b0a36f9a79c@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28.9.2018 23:12, Olof Johansson wrote:
> On Fri, Sep 28, 2018 at 10:15 AM Jolly Shah <JOLLYS@xilinx.com> wrote:
>>
>> Hi Olof,
>>
>> Thanks for the review. Pushed v4 with suggested fixes. Let us know if series looks good and we can create pull request for same.
>>
>> Thanks,
>> Jolly Shah
> 
> I'm happy with this one, thanks for revising the patchset with the fixes.
> 
> Feel free to add:
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> to the patches.

Just for clarification. I have checked driver/clk and patches should
still go via Michael or Stephen.
Firmware code is already in arm-soc tree that's why I would expect
Michael/Stephen should review it and then it shouldn't be a problem to
take this via arm-soc tree.

Olof: Please correct me if I am wrong and you are happy to take it via
arm-soc directly.

Thanks,
Michal
