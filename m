From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 08:54:25 +0200
Subject: [GIT PULL] STi DT updates for v4.9
In-Reply-To: <4599921.Xv3Qd3jgsj@wuerfel>
References: <c83fda3c-5120-a55b-dfb0-f550cbaf777a@st.com>
 <4599921.Xv3Qd3jgsj@wuerfel>
Message-ID: <45b2a5fb-d573-e196-fac2-de60f42efb24@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On 09/13/2016 05:27 PM, Arnd Bergmann wrote:
> On Friday, September 2, 2016 3:58:00 PM CEST Patrice Chotard wrote:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
>>
>> for you to fetch changes up to ba5ba11906d5462993f5fd4e3da4d234505427a0:
>>
>>   ARM: dts: STiH41x-b2020: Update gpio specifier (2016-09-02 15:15:14 +0200)
>>
>> ----------------------------------------------------------------
>>
>> STi dts fixes and new STi 96board support:
>>
>> Add thermal node for STiH407 family boards
>> Add specific nodes for STMicroelectronics 96Board
>> Add new B2260 STi board file = 96Board
>> Fix ahci issue on STiH407 family
>> Fix debugfs/pinctrl kernel warning
>> Update gpio-cells and gpio specifier
>>
> 
> Pulled into next/dt. The URL had no tag name, but I found the tag "sti-dt-for-v4.9-1"

OK i will check that point.

> in your tree with that commit ID, so I pulled that.

Perfect !

Thanks
>     
> Not sure what went wrong on your end, it wasn't a big deal but please
> try to always include the tag. Thanks!
> 
> 	Arnd
> 
