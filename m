From: javier.martin@vista-silicon.com (Javier Martin)
Date: Mon, 12 Dec 2011 12:43:43 +0100
Subject: [PATCH v4 0/2] Add support form eMMa-PrP in i.MX2 chips as a mem2mem
 device.
Message-ID: <1323690225-15799-1-git-send-email-javier.martin@vista-silicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
 Patch order inverted as requested by Mauro.
 Now adjusting of the image dimensions is made using  v4l_bound_align_image().
 Some coding style fixes.
