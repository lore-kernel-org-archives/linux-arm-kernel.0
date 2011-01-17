From: ccross@android.com (Colin Cross)
Date: Mon, 17 Jan 2011 14:17:22 -0800
Subject: [PATCH] arm/tegra: Fix tegra irq_data conversion
In-Reply-To: <AANLkTi=CmtiM7jja2vxB8tUjZFVQEY739X3uREJD+MXk@mail.gmail.com>
References: <20110116054127.1395.68849.stgit@localhost6.localdomain6>
	<20110116102158.GC15575@mail.wantstofly.org>
	<AANLkTi=CmtiM7jja2vxB8tUjZFVQEY739X3uREJD+MXk@mail.gmail.com>
Message-ID: <AANLkTin_D7VpX2yQAcTC-1d67iqRh+-yTX028MM8=Cto@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 16, 2011 at 7:53 AM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jan 16, 2011 at 2:21 AM, Lennert Buytenhek
> <buytenh@wantstofly.org> wrote:
>> On Sat, Jan 15, 2011 at 10:41:27PM -0700, Grant Likely wrote:
>>
>>> Commit 37337a8d5e68d6e19075dbdb3acf4f1011dae972, "ARM: tegra: irq_data
>>> conversion." missed changing one reference to 'irq' in the function
>>> tegra_gpio_irq_set_type(). ?This patch fixes the build error.
>>>
>>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>>
>> Acked-by: Lennert Buytenhek <buytenh@secretlab.ca>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
>> I built this queue against all defconfigs, but there doesn't seem to
>> be one for tegra at the moment, which is why I missed this.
>
> Yep, planning on fixing this for .39.
>
>
> -Olof
>

This should get fixed in .38.  Has someone picked it up, or should I
put it in through my tree?
