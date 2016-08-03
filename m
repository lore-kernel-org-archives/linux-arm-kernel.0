From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 3 Aug 2016 08:27:48 -0700
Subject: [PATCH 2/2] MMC: meson: inital support for GXBB platforms
In-Reply-To: <57A13CB5.4000006@samsung.com>
References: <20160803003045.24980-1-khilman@baylibre.com>
 <CGME20160803003156epcas1p2473ed7677a97642c892baefa5dcffddd@epcas1p2.samsung.com>
 <20160803003045.24980-2-khilman@baylibre.com> <57A13CB5.4000006@samsung.com>
Message-ID: <CAOi56cXq2Vqz+7xT1J7NO01cV7HwMt=U-_7NPwEFf1D01R2VXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 2, 2016 at 5:37 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Kevin,
>
> On 08/03/2016 09:30 AM, Kevin Hilman wrote:
>> Initial support for the SD/eMMC controller in the Amlogic S905/GXBB
>> family of SoCs.
>>
>> Currently working for the SD and eMMC interfaces, but not yet tested for
>> SDIO.
>>
>> Tested external SD card and internal eMMC on meson-gxbb-p200 and
>> meson-gxbb-odroidc2.
>
> Before sending patch, run the checkpatch.pl for your patch.

Yes, sorry about that.  This patch was sent prematurely.

Kevin
