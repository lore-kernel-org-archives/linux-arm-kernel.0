From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 14 Aug 2017 16:01:24 +0200
Subject: [PATCH 4/8] gpio: zynq: Provided workaround for GPIO
In-Reply-To: <CACRpkdaM7TN8pg=E6ETJrZYfN8AC-CNY8CWJrWUrsX=EP+gnRg@mail.gmail.com>
References: <cover.1502103715.git.michal.simek@xilinx.com>
 <4f1f7ed79879d17e38ffda095d631d0f561c2818.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdaM7TN8pg=E6ETJrZYfN8AC-CNY8CWJrWUrsX=EP+gnRg@mail.gmail.com>
Message-ID: <6ff1ce3b-1051-d125-c044-a5b3ad5aa2fd@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14.8.2017 15:57, Linus Walleij wrote:
> On Mon, Aug 7, 2017 at 1:01 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> 
>> From: Swapna Manupati <swapna.manupati@xilinx.com>
>>
>> This patch provides workaround in the gpio driver
>> for Zynq and ZynqMP Platforms by reading pin value
>> of EMIO banks through DATA register as it was unable
>> to read the value of it from DATA_RO register.
>>
>> Signed-off-by: Swapna Manupati <swapnam@xilinx.com>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> 
> Patch applied.
> 
> (I hope my random application of patches does not screw things
> up, then I guess I need to back some out.)

Should be fine.

Thanks,
Michal
