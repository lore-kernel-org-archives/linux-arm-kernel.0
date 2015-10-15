From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 15 Oct 2015 12:01:04 -0400
Subject: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and pcie
In-Reply-To: <5192855.p6QLDWTiVi@wuerfel>
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com>
 <1444919145-30845-2-git-send-email-w-kwok2@ti.com>
 <5192855.p6QLDWTiVi@wuerfel>
Message-ID: <561FCDC0.3080109@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 10:51 AM, Arnd Bergmann wrote:
> On Thursday 15 October 2015 10:25:44 WingMan Kwok wrote:
>> On TI's Keystone platforms, several peripherals such as the
>> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
>> require the use of a SerDes for converting SoC parallel data into
>> serialized data that can be output over a high-speed electrical
>> interface, and also converting high-speed serial input data
>> into parallel data that can be processed by the SoC.  The
>> SerDeses used by those peripherals, though they may be different,
>> are largely similar in functionality and setup.
>>
>> This patch provides a SerDes phy driver implementation that can be
>> used by the above mentioned peripheral drivers to configure their
>> respective SerDeses.
>>
>> v1:

--------cut-------------------------------------------------------------

>> + * Redistributions in binary form must reproduce the above copyright
>> + * notice, this list of conditions and the following disclaimer in the
>> + * documentation and/or other materials provided with the
>> + * distribution.
>
> The current code does not do this when compiled, which might be a
> problem for distributors. Can you clarify the license?
>
Arnd,

Can you elaborate on this? I did a grep on the string "Redistributions 
in binary form must reproduce the above copyright" and I could find 
several instance of this. So I am not sure what you mean by "The current 
code does not do this when compiled".

Thanks
-- 
Murali Karicheri
Linux Kernel, Keystone
