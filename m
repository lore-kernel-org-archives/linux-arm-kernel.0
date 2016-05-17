From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 16 May 2016 18:52:31 -0700
Subject: [PATCH v2 1/2] Documentation: DT: bindings: Add Broadcom STB PCIe
 bindings
In-Reply-To: <8520D5D51A55D047800579B094147198258955CE@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1462475700-1654-1-git-send-email-f.fainelli@gmail.com>
 <1462475700-1654-2-git-send-email-f.fainelli@gmail.com>
 <8520D5D51A55D047800579B094147198258955CE@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <573A795F.2040209@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2016 07:45 AM, Bharat Kumar Gogada wrote:
>> +- brcm,log2-scb-sizes: log2 size of the SCB window that is mapped to
>> +PCIe space
>> +  there must be exactly one value per memory controller present in the
>> +system
>> +  (ranges from 1 to 3)
> 
> Can you please give more insight on what does this property do ?

There is another part of the thread that should tell you a bit more what
this is about, here is where it starts:

http://www.spinics.net/lists/linux-pci/msg50973.html

And this is where we discuss what we should be doing about it:

http://www.spinics.net/lists/linux-pci/msg51070.html
-- 
Florian
