From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 23 Mar 2018 22:06:27 +0800
Subject: [PATCH 1/2] dt-bindings: clock: reset: Add AXG AO Clock and Reset
 Bindings
In-Reply-To: <CAOFm3uFj-7kZNp6b3SerOzQ8Amfa5Usod+MxwvZJ1E1Z_V9VJA@mail.gmail.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
 <20180209070026.193879-2-yixun.lan@amlogic.com>
 <CAOFm3uFj-7kZNp6b3SerOzQ8Amfa5Usod+MxwvZJ1E1Z_V9VJA@mail.gmail.com>
Message-ID: <dffeba58-1326-1dbd-38fc-c3b0f51d9c73@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe

On 02/09/2018 07:07 PM, Philippe Ombredanne wrote:
> On Fri, Feb 9, 2018 at 8:00 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:
>> Add dt-bindings headers for the Meson-AXG's AO clock and
>> reset controller.
>>
>> CC: <devicetree@vger.kernel.org>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
>> ---
>>  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
>>  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
>>  2 files changed, 46 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h
>>
>> diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
>> new file mode 100644
>> index 000000000000..78683abb4247
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/axg-aoclkc.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD) */
> 
> nit... BSD is not a valid license id as documented in LICENSES [1] :
> please use one of these:
> BSD-2-Clause or BSD-3-Clause
> 
> Thank you!
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/LICENSES/preferred
> 


  Thanks for the hint

  I'll update to BSD-3-Clause, since this license is just a copy from
previous gxbb-aoclkc.h file.

Yixun
