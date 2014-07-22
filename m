From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 22 Jul 2014 19:02:08 +0200
Subject: [PATCH v4] pcie: Add Xilinx PCIe Host Bridge IP driver
In-Reply-To: <CAErSpo41HwMferWm8q69Sz0t-Cs1WHgwwVp1VKsoxxyvrgQhfQ@mail.gmail.com>
References: <1404361654-2894-1-git-send-email-sthokal@xilinx.com>
 <20140716173824.GA24357@google.com>
 <CA+mB=1JupzQy+R14kKAk7mTJR2FcZ+cQv-uXQSB6jEVBW95aGQ@mail.gmail.com>
 <CAErSpo41HwMferWm8q69Sz0t-Cs1WHgwwVp1VKsoxxyvrgQhfQ@mail.gmail.com>
Message-ID: <dc252e61-3179-4f51-90e6-f92929e93d40@BN1AFFO11FD030.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2014 06:08 PM, Bjorn Helgaas wrote:
> On Mon, Jul 21, 2014 at 11:10 PM, Srikanth Thokala <sthokal@xilinx.com> wrote:
>> On Wed, Jul 16, 2014 at 11:08 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>>> ...
>>> I see I forgot to ask for a MAINTAINERS entry for this driver.  Can
>>> you add one?
>>
>> There was a discussion on this earlier and Michal mentioned it is not
>> required as it is
>> handled by our Xilinx record.
>>
>> Here is the reply from Michal to the MAINTAINERS update comment,
>>
>> < Reply from Michal >
>>
>>> Please also include a MAINTAINERS update for drivers/pci/host/pci-xilinx.c.
>>
>> This should be handle by our record that's why MAINTAINERS update is
>> not necessary.
>> (N: xilinx below)
> 
> That's technically true in the sense that get_maintainer.pl will do
> the right thing, but I often review patches in email (without
> extracting them), so it's more convenient to just look in MAINTAINERS
> to see if they have the right acks.  But I guess I can deal with it
> either way.

There is also another reason for using just this fragment.
Because developers and their responsibilities are changing so often
and I just know who is responsible for it at that time.

Thanks,
Michal
