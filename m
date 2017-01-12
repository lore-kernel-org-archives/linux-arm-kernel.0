From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 12 Jan 2017 13:48:16 +0530
Subject: [PATCH v2 3/3] phy: rockchip-inno-usb2: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <CAMz4ku+X8v2HH5L_fS60naNTqR1ZFKYeWuXuHqjg0UsHQq1dsQ@mail.gmail.com>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482307697.git.baolin.wang@linaro.org>
 <23666cc1a5ff123ece5bdbb9821d1eab280d0927.1482307697.git.baolin.wang@linaro.org>
 <CAMz4kuJP9Q7Ly4uRBjCFU32YzbVbnsGyk+wHc+M=g8W=uDBsEQ@mail.gmail.com>
 <CAMz4ku+X8v2HH5L_fS60naNTqR1ZFKYeWuXuHqjg0UsHQq1dsQ@mail.gmail.com>
Message-ID: <58773BC8.2050808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 12 January 2017 12:13 PM, Baolin Wang wrote:
> On 3 January 2017 at 13:54, Baolin Wang <baolin.wang@linaro.org> wrote:
>> Hi Kison and Heiko,
>>
>> On 21 December 2016 at 16:12, Baolin Wang <baolin.wang@linaro.org> wrote:
>>> According to the documentation, we should set the EXTCON_USB when
>>> one SDP charger connector was reported.
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>>
>> Could you apply this patch if there are no other comments? Thanks.

Does it fix something? Or else it can go in the next merge window.

Thanks
Kishon
