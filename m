From: vincent.abriou@st.com (Vincent ABRIOU)
Date: Mon, 15 Feb 2016 17:44:13 +0100
Subject: [PATCH v2 16/17] drm/sti: removed optional dummy encoder
 mode_fixup function.
In-Reply-To: <7f47c6a7b00e4f16af672ebf3a277e31ad117e21.1455540137.git.palminha@synopsys.com>
References: <cover.1455540137.git.palminha@synopsys.com>
 <7f47c6a7b00e4f16af672ebf3a277e31ad117e21.1455540137.git.palminha@synopsys.com>
Message-ID: <56C2005D.3020302@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/15/2016 02:01 PM, Carlos Palminha wrote:
> mode_fixup function for encoder drivers became optional with patch
> http://patchwork.freedesktop.org/patch/msgid/1455106522-32307-1-git-send-email-palminha at synopsys.com
>
> This patch set nukes all the dummy mode_fixup implementations.
>
> (made on top of Daniel topic/drm-misc branch)
>
> Signed-off-by: Carlos Palminha <palminha@synopsys.com>
> ---
>   drivers/gpu/drm/sti/sti_tvout.c | 10 ----------
>   1 file changed, 10 deletions(-)
>

Acked-by: Vincent Abriou <vincent.abriou@st.com>

BR
Vincent
