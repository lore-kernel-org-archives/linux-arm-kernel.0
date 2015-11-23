From: mark.yao@rock-chips.com (Mark yao)
Date: Mon, 23 Nov 2015 17:39:41 +0800
Subject: [PATCH v2 2/2] drm/rockchip: Convert the probe function to the
 generic drm_of_component_probe()
In-Reply-To: <1448029325-14602-3-git-send-email-Liviu.Dudau@arm.com>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <1448029325-14602-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5652DEDD.60603@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?11?20? 22:22, Liviu Dudau wrote:
> Initial attempt to convert rockchip to drm_of_component_probe() missed the
> difference between ports and encoders when using the compare_of() function.
> Now that drm_of_component_probe() has been enhanced, let's try again the
> conversion.
>
> Signed-off-by: Liviu Dudau<Liviu.Dudau@arm.com>

Looks good for me, and it works on popmetal board, so
      Acked-by: Mark Yao <mark.yao@rock-chips.com>

Thanks.

-- 
?ark Yao
