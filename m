From: olivier.moysan@st.com (Olivier Moysan)
Date: Tue, 13 Mar 2018 17:27:08 +0100
Subject: [PATCH 3/3] ASoC: dmaengine_pcm: document process callback
In-Reply-To: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1520958428-10930-4-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing description of process callback.

Fixes: 78648092ef46 ("ASoC: dmaengine_pcm: add processing support")
Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 include/sound/dmaengine_pcm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 47ef486852ed..e3481eebdd98 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -118,6 +118,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
  *   PCM substream. Will be called from the PCM drivers hwparams callback.
  * @compat_request_channel: Callback to request a DMA channel for platforms
  *   which do not use devicetree.
+ * @process: Callback used to apply processing on samples transferred from/to
+ *   user space.
  * @compat_filter_fn: Will be used as the filter function when requesting a
  *  channel for platforms which do not use devicetree. The filter parameter
  *  will be the DAI's DMA data.
-- 
1.9.1
