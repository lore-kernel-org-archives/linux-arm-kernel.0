From: baolin.wang@linaro.org (Baolin Wang)
Date: Tue, 3 Jan 2017 13:54:30 +0800
Subject: [PATCH v2 3/3] phy: rockchip-inno-usb2: Set EXTCON_USB when
 EXTCON_CHG_USB_SDP was set
In-Reply-To: <23666cc1a5ff123ece5bdbb9821d1eab280d0927.1482307697.git.baolin.wang@linaro.org>
References: <7b9836ce2ca34118a2acd1ea113605a5f13b4439.1482307697.git.baolin.wang@linaro.org>
 <23666cc1a5ff123ece5bdbb9821d1eab280d0927.1482307697.git.baolin.wang@linaro.org>
Message-ID: <CAMz4kuJP9Q7Ly4uRBjCFU32YzbVbnsGyk+wHc+M=g8W=uDBsEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kison and Heiko,

On 21 December 2016 at 16:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> According to the documentation, we should set the EXTCON_USB when
> one SDP charger connector was reported.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Could you apply this patch if there are no other comments? Thanks.

-- 
Baolin.wang
Best Regards
