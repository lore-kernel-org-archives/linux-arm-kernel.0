From: jhnikula@gmail.com (Jarkko Nikula)
Date: Tue, 21 Dec 2010 19:25:33 +0200
Subject: [PATCH 0/2] omap: rx51: Fix broken fb on RX51/N900
Message-ID: <1292952335-21314-1-git-send-email-jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Commit 60d24ee "Added video data to support tvout on rx51" broke the
framebuffer on N900. Here are two patches where 1st one does a little cleanup
to be sync with the 2nd fixing the issue. I've tested that both tvout and lcd
are working.

-- 
Jarkko
