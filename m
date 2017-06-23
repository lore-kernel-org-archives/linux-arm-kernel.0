From: dinguyen@kernel.org (Dinh Nguyen)
Date: Fri, 23 Jun 2017 09:20:43 -0500
Subject: [GIT PULL 1/2] SoCFPGA DTS updates for v4.13
In-Reply-To: <CAK8P3a3JrZidaUVVA+s0wu+ZKUvzWMddTc-EjL35C5PmknQd-Q@mail.gmail.com>
References: <1498059352-9483-1-git-send-email-dinguyen@kernel.org>
 <CAK8P3a3JrZidaUVVA+s0wu+ZKUvzWMddTc-EjL35C5PmknQd-Q@mail.gmail.com>
Message-ID: <b2ba6705-06ef-1576-d289-0134645f1ca6@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/23/2017 07:04 AM, Arnd Bergmann wrote:
> On Wed, Jun 21, 2017 at 5:35 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
>> Hi Arnd, Kevin, and Olof:
>>
>> Please pull in these DTS updates for v4.13.
>>
>> Thanks,
>> Dinh
>>
>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>
>>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_dts_for_v4.13
>>
>> for you to fetch changes up to 000e6f73dcc52d970706010d3bbc74710db4933c:
>>
>>   ARM: dts: socfpga: set the i2c frequency (2017-05-26 11:19:28 -0500)
>>
>> ----------------------------------------------------------------
>> SoCFPGA DTS updates for v4.13
>> - Fix clocks node the EMACs
>> - VINING board updtes
>>         - Remove I2C EEPROMs and LED node
>>         - Add QSPI device
>>         - Add 2nd ethernet alias
>> - Add 'clock-frequency' binding for i2c node
>>
>> ----------------------------------------------------------------
>> Dinh Nguyen (1):
>>       ARM: dts: socfpga: set the i2c frequency
>>
>> Marek Vasut (6):
>>       ARM: socfpga: Increase max number of GPIOs
>>       ARM: dts: socfpga: Fix the ethernet clock phandle
>>       ARM: dts: socfpga: Enable QSPI support on VINING FPGA
>>       ARM: dts: socfpga: Remove I2C EEPROMs from VINING FPGA
>>       ARM: dts: socfpga: Drop LED node from VINING FPGA
>>       ARM: dts: socfpga: Add second ethernet alias to VINING FPGA
> 
> Your description does not explain why the Kconfig patch is included
> in this branch and also in the separate pull request. Is there a strong
> dependency here, or could you rebase the dts patches on top of
> a vanilla 4.12-rc1 and resend?
> 

Sorry about that. The Kconfig patch should not have been part of this
series. Let me try again.

Thanks,
Dinh
