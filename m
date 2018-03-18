From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 18 Mar 2018 23:48:08 +0100
Subject: [PATCH 0/2] drm/sun4i: Fix some error handling paths in
 'sun4i_hdmi_bind()'
Message-ID: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've splitted these fixes into 2 patches becasue they do not fixe the same
commit.

Christophe JAILLET (2):
  drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
  drm/sun4i: hdmi: Fix another error handling path in
    'sun4i_hdmi_bind()'

 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.14.1
