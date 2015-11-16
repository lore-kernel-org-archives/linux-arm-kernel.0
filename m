From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Mon, 16 Nov 2015 09:35:53 +0100
Subject: [PATCH v2] crypto: sun4i-ss: add missing statesize
Message-ID: <1447662954-1788-1-git-send-email-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello

The current sun4i-ss cannot be loaded with the error "Failed to load md5".
The following patch will fix that.

Changes since v1:
- Add the correct fixes tag.
- Add the correct #version comment for stable.
- Be more precise against the commit who made this change necessary.

Regards
