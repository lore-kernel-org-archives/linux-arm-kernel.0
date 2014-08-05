From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 05 Aug 2014 10:02:54 +0200
Subject: Formal license ambiguity in arch/arm/boot/dts/sun?i-a*.dts
In-Reply-To: <20140804192510.GF3952@lukather>
References: <20140731192016.GA6869@excalibur.cnev.de>
 <20140803130430.GY3952@lukather> <201408031959.27607.arnd@arndb.de>
 <20140804192510.GF3952@lukather>
Message-ID: <53E08FAE.3000205@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/04/2014 09:25 PM, Maxime Ripard wrote:
> On Sun, Aug 03, 2014 at 07:59:27PM +0200, Arnd Bergmann wrote:
>> On Sunday 03 August 2014, Maxime Ripard wrote:
>>> Thanks for reporting this.
>>>
>>> From a quick grep, the issue is actually broader than just
>>> Allwinner. At least the following platforms seem to do the same:
>>>   - mvebu
>>>   - axm5516
>>>   - bcm
>>>   - berlin
>>>   - ea3250
>>>   - ecx-2000
>>>   - highbank
>>>   - imx / mxs
>>>   - lpc32xx
>>>   - phy3250
>>>   - picoxcell
>>>   - shmobile
>>>   - rockchip
>>>   - socfpga
>>>   - spear
>>>   - ste
>>>   - zynq
>>>
>>> Would you mind sending a patch to fix all these?
>>
>> I would actually prefer if we could migrate a lot of these files to BSD license,
>> provided the original authors agree. We want the dtb blobs to be embeddable into
>> boot loaders of any license.
> 
> Even though I'd be open to having my contributions to DTBs under the
> BSD

p.s.

I've a patch adding a new dts file for the bananapi pending. I might as well
relicense that before submitting V2. So what shall we use 2 clause BSD or MIT ?

I've a slight preference for MIT, but both are fine.

Regards,

Hans
