From: olof@lixom.net (Olof Johansson)
Date: Sat, 23 Jun 2018 15:15:22 -0700
Subject: [GIT PULL] ARM: dts: socfpga: NAND fixes for v4.17
In-Reply-To: <34a98cdf-53de-b146-4471-ff1dc577b12e@kernel.org>
References: <20180515134416.11349-1-dinguyen@kernel.org>
 <34a98cdf-53de-b146-4471-ff1dc577b12e@kernel.org>
Message-ID: <CAOesGMiJSF8=CyzBnyyOB_wwJNtz+azSU2gSYRkbq4njLfs3Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2018 at 1:41 PM, Dinh Nguyen <dinguyen@kernel.org> wrote:
> Ping?
>
> On 05/15/2018 08:44 AM, Dinh Nguyen wrote:
>> Hi Arnd, Kevin, and Olof:
>>
>> Please pull in these NAND fixes for v4.17.
>>
>> Thanks,
>> Dinh
>>
>> The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:
>>
>>   Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_nand_fix_v4.17
>>
>> for you to fetch changes up to 3877ef7a1ccecaae378c497e1dcddbc2dccb664c:
>>
>>   ARM: dts: socfpga: Fix NAND controller node compatible for Arria10 (2018-05-14 10:16:56 -0500)
>>
>> ----------------------------------------------------------------
>> ARM: dts: socfpga: fix NAND support
>> - NAND should be using nand_x_clk, not nand_clk
>> - fix NAND node compatible for Cyclone5 and Arria10

Merged now, as per other email thread -- please make sure you send to
arm at kernel.org or there's a chance they will be missed.


-Olof
