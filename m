From: brad.mouring@ni.com (Brad Mouring)
Date: Wed, 27 Apr 2016 10:35:49 -0500
Subject: [PATCH v3 0/2] Control PL310 pwr_ctrl register through DT
In-Reply-To: <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
References: <1461015411-14000-1-git-send-email-brad.mouring@ni.com>
Message-ID: <1461771351-11645-1-git-send-email-brad.mouring@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This revision of the patches addresses the concerns on documenting
the DT bindings brought up here:
http://www.spinics.net/lists/arm-kernel/msg500784.html

The technical change remains functionally the same, however v2 was
needlessly setting the bits twice in the case that the binding
existed and was non-zero.

Thanks!

Brad
