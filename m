From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 03 Jun 2015 11:40:33 +0800
Subject: [PATCH v2] drm/rockchip: Add BGR formats to VOP
In-Reply-To: <CAAFQd5A1HTV+LdkTSeQrjX=MpQEseY9-NF5PySJq_B+rrmTMkw@mail.gmail.com>
References: <1431341739-12523-1-git-send-email-tfiga@chromium.org>
 <CAAFQd5A1HTV+LdkTSeQrjX=MpQEseY9-NF5PySJq_B+rrmTMkw@mail.gmail.com>
Message-ID: <556E7731.6020403@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?30? 02:56, Tomasz Figa wrote:
> On Mon, May 11, 2015 at 7:55 PM, Tomasz Figa <tfiga@chromium.org> wrote:
>> VOP can support BGR formats in all windows thanks to red/blue swap option
>> provided in WINx_CTRL0 registers. This patch enables support for
>> ABGR8888, XBGR8888, BGR888 and BGR565 formats by using this feature.
>>
>> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
>> ---
>>   drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 33 +++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>
>> Changes since v1:
>> (https://patchwork.kernel.org/patch/6369531/)
>>   - Fixed register addresses for win2/3 and hwc (reported by Mark Yao).
> Gentle ping.
Applied to my drm-next:-)
> Best regards,
> Tomasz
>
>
>


-- 
?ark Yao
