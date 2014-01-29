From: b.brezillon@overkiz.com (boris brezillon)
Date: Wed, 29 Jan 2014 11:20:42 +0100
Subject: [RFC PATCH 0/9] mtd: nand: add sunxi NAND Flash Controller support
In-Reply-To: <CAL_JsqJNd_gtn-cCLbZxT=s5NkkXp0DZkJkZrBhWiaL6Js=woQ@mail.gmail.com>
References: <1389190924-26226-1-git-send-email-b.brezillon@overkiz.com>	<52D1494E.9090303@overkiz.com>
 <CAL_JsqJNd_gtn-cCLbZxT=s5NkkXp0DZkJkZrBhWiaL6Js=woQ@mail.gmail.com>
Message-ID: <52E8D5FA.9070400@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rob,

On 23/01/2014 16:22, Rob Herring wrote:
> On Sat, Jan 11, 2014 at 7:38 AM, boris brezillon
> <b.brezillon@overkiz.com> wrote:
>> On 08/01/2014 15:21, Boris BREZILLON wrote:
>>> Hello,
>>>
>>> This series add the sunxi NFC support with up to 8 NAND chip connected.
>>> I'm still in the early stages drivers development and some key features
>>> are
>>> missing, but it's usable (I tested it on the cubietruck board).
>>>
>>> Here's what's missing:
>>>    - HW ECC support
>>>    - DMA support
>>>    - HW randomization support
>>>    - many more improvements
>>>
>>> This series depends on Emilio's patch series implementing mod0 clks
>>>
>>> (http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185478.html)
>>> + an other patch not yet posted
>>>
>>> (http://git.elopez.com.ar/linux/commits/5b4eb3ac406b9c98965714d40e8dd6da943d1ab0)
>>
>> During my reasearch regarding the HW ECC and HW randomizer of the Allwinner
>> NAND flash controller I found this document describing the Altera NAND flash
>> controller
>> (which is in turn based on a cadence IP):
> Which may be similar to drivers/mtd/nand/denali.c as Cadence bought Denali?
Actually I was wrong, the sunxi and the cadence IP have nothing in common.
This was pointed out by Henrik (see this thread :
https://groups.google.com/forum/#!searchin/linux-sunxi/nand/linux-sunxi/x69tFBi95Zk/bNyJlWWOV8oJ 
<https://groups.google.com/forum/#%21searchin/linux-sunxi/nand/linux-sunxi/x69tFBi95Zk/bNyJlWWOV8oJ>).


Sorry for the false hopes.

Best Regards,

Boris

>
> Rob
