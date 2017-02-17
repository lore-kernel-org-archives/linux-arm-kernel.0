From: adanhawthorn@gmail.com (Nathan Howard)
Date: Fri, 17 Feb 2017 15:16:21 -0500
Subject: [PATCH 5/5] staging: bcm2835-audio: bcm2835.h: fix line length coding
 style issue
In-Reply-To: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
References: <1487362603-15967-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487362603-15967-5-git-send-email-adanhawthorn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix checkpatch.pl warning of the form "WARNING: line over 80 characters."

Signed-off-by: Nathan Howard <adanhawthorn@gmail.com>
---
 drivers/staging/bcm2835-audio/bcm2835.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
index 08f7ad6..16d7006 100644
--- a/drivers/staging/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/bcm2835-audio/bcm2835.h
@@ -163,8 +163,10 @@ int bcm2835_audio_write(struct bcm2835_alsa_stream *alsa_stream,
 			unsigned int count,
 			void *src);
 void bcm2835_playback_fifo(struct bcm2835_alsa_stream *alsa_stream);
-unsigned int bcm2835_audio_retrieve_buffers(struct bcm2835_alsa_stream *alsa_stream);
+unsigned int bcm2835_audio_retrieve_buffers(
+		struct bcm2835_alsa_stream *alsa_stream);
 void bcm2835_audio_flush_buffers(struct bcm2835_alsa_stream *alsa_stream);
-void bcm2835_audio_flush_playback_buffers(struct bcm2835_alsa_stream *alsa_stream);
+void bcm2835_audio_flush_playback_buffers(
+		struct bcm2835_alsa_stream *alsa_stream);
 
 #endif /* __SOUND_ARM_BCM2835_H */
-- 
2.7.4
