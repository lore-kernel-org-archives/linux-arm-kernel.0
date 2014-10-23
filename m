From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 23 Oct 2014 15:49:28 +0200
Subject: [PATCH v2] i2c:at91: add bound checking on SMBus block length
 bytes
In-Reply-To: <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
References: <1408585181-10131-1-git-send-email-mark.roszko@gmail.com>
 <20141021071434.GI7443@ldesroches-Latitude-E6320>
 <CAJjB1qK2fQgBukgeM0EqZs865_LF6jABGEtQbh8cqtQXGoSTAg@mail.gmail.com>
Message-ID: <20141023134927.GQ7443@ldesroches-Latitude-E6320>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 23, 2014 at 09:28:55AM -0400, Mark Roszko wrote:
> Hi Ludovic,
> 
> Wolfram took in the patch quietly awhile back. It's in the 3.17 kernel
> and backported to some of the older trees.
> https://github.com/torvalds/linux/commit/75b81f339c6af43f6f4a1b3eabe0603321dade65

Great, sorry for the noise so. It seems I have checked it from a wrong
branch.

Ludovic

> 
> Regards,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
