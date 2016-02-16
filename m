From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 16 Feb 2016 11:29:39 +0100
Subject: [PATCH v4 2/2] s5p-mfc: add the support of
 V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME.
In-Reply-To: <1453187230-97231-3-git-send-email-wuchengli@chromium.org>
References: <1453187230-97231-1-git-send-email-wuchengli@chromium.org>
 <1453187230-97231-3-git-send-email-wuchengli@chromium.org>
Message-ID: <56C2FA13.3020106@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 08:07, Wu-Cheng Li wrote:
> There is a new control V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME to
> force an encoder key frame. It is the same as requesting
> V4L2_MPEG_MFC51_VIDEO_FORCE_FRAME_TYPE_I_FRAME.
> 
> Signed-off-by: Wu-Cheng Li <wuchengli@chromium.org>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
