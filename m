From: ccross@android.com (Colin Cross)
Date: Wed, 26 Jan 2011 21:42:49 -0800
Subject: [PATCH] arm/tegra: Fix tegra irq_data conversion
In-Reply-To: <AANLkTinTzT-UiVGdg2M99VpYQCyWONh_RDrwExsasv_d@mail.gmail.com>
References: <20110116054127.1395.68849.stgit@localhost6.localdomain6>
	<20110116102158.GC15575@mail.wantstofly.org>
	<AANLkTi=CmtiM7jja2vxB8tUjZFVQEY739X3uREJD+MXk@mail.gmail.com>
	<AANLkTin_D7VpX2yQAcTC-1d67iqRh+-yTX028MM8=Cto@mail.gmail.com>
	<AANLkTinitxQLUxFZoVW=oZcNkAWF5k4FLJh5-f6o5pt-@mail.gmail.com>
	<AANLkTinTzT-UiVGdg2M99VpYQCyWONh_RDrwExsasv_d@mail.gmail.com>
Message-ID: <AANLkTikdAB-scO=dRwhggZD--dJoWq_tFGL-ay1OdY9E@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 26, 2011 at 7:41 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Mon, Jan 17, 2011 at 3:49 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>> On Mon, Jan 17, 2011 at 3:17 PM, Colin Cross <ccross@android.com> wrote:
>>> On Sun, Jan 16, 2011 at 7:53 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> On Sun, Jan 16, 2011 at 2:21 AM, Lennert Buytenhek
>>>> <buytenh@wantstofly.org> wrote:
>>>>> On Sat, Jan 15, 2011 at 10:41:27PM -0700, Grant Likely wrote:
>>>>>
>>>>>> Commit 37337a8d5e68d6e19075dbdb3acf4f1011dae972, "ARM: tegra: irq_data
>>>>>> conversion." missed changing one reference to 'irq' in the function
>>>>>> tegra_gpio_irq_set_type(). ?This patch fixes the build error.
>>>>>>
>>>>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>>>>
>>>>> Acked-by: Lennert Buytenhek <buytenh@secretlab.ca>
>>>>
>>>> Acked-by: Olof Johansson <olof@lixom.net>
>>>>
>>>>> I built this queue against all defconfigs, but there doesn't seem to
>>>>> be one for tegra at the moment, which is why I missed this.
>>>>
>>>> Yep, planning on fixing this for .39.
>>>>
>>>>
>>>> -Olof
>>>>
>>>
>>> This should get fixed in .38. ?Has someone picked it up, or should I
>>> put it in through my tree?
>>
>> I don't think Olof picked it up (seeing as he only acked it and it's
>> not in Linus' tree). ?You should take it through your tree.
>
> Ping? ?I've not seen this hit Linus' tree yet. ?Do you want me to take
> care of it?

I confused your previous request for the struct clk patch with this
patch.  I just sent a pull request with both this and the struct clk
patch to Linus.
