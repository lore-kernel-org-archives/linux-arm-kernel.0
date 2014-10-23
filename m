From: mark.roszko@gmail.com (Mark Roszko)
Date: Thu, 23 Oct 2014 09:28:55 -0400
Subject: [PATCH v2] i2c:at91: add bound checking on SMBus block length
 bytes
In-Reply-To: <20141021071434.GI7443@ldesroches-Latitude-E6320>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com>
 <20141021071434.GI7443@ldesroches-Latitude-E6320>
Message-ID: <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ludovic,

Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
and backported to some of the older trees.
https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe0603321dade65

Regards,
Mark
