From: olivier.moysan@st.com (Olivier Moysan)
Date: Thu, 9 Nov 2017 15:07:57 +0100
Subject: [PATCH 1/2] ASoC: add mclk-fs to audio graph card binding
In-Reply-To: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
References: <1510236478-2351-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1510236478-2351-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add mclk-fs support to audio graph card
as initially supported in simple card.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-card.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
index 6e6720a..d04ea3b 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
@@ -17,6 +17,7 @@ Below are same as Simple-Card.
 - bitclock-master
 - bitclock-inversion
 - frame-inversion
+- mclk-fs
 - dai-tdm-slot-num
 - dai-tdm-slot-width
 - clocks / system-clock-frequency
-- 
1.9.1
