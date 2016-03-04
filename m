From: mark.yao@rock-chips.com (Mark yao)
Date: Fri, 04 Mar 2016 09:04:57 +0800
Subject: [PATCH] drm/rockchip: vop: fix crtc size in plane check
In-Reply-To: <1456143779-16208-1-git-send-email-john@metanate.com>
References: <1456143779-16208-1-git-send-email-john@metanate.com>
Message-ID: <56D8DF39.8020104@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?02?22? 20:22, John Keeping wrote:
> If the geometry of a crtc is changing in an atomic update then we much

I think "we much validate" should be "we must validate".:-)

> validate the plane size against the new state of the crtc and not the
> current size, otherwise if the crtc size is increasing the plane will be
> cropped at the previous size and will not fill the screen.
>
> Signed-off-by: John Keeping<john@metanate.com>

-- 
?ark Yao
