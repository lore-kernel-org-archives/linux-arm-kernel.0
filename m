From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 24 Oct 2016 17:05:52 +0530
Subject: [PATCH 2/5] ARM: davinci: Don't append git rev to local version
In-Reply-To: <1477075018-20176-3-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
 <1477075018-20176-3-git-send-email-david@lechnology.com>
Message-ID: <20f3efba-4f79-3675-d2ce-09efe90fb692@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 October 2016 12:06 AM, David Lechner wrote:
> In the davinci default configuration, don't append the git revision to
> the local kernel version by. This seems like the more desirable default
> value.

Why? To the contrary I actually quite like the fact that the git commit
is appended to version string. Makes it easy for me to cross-check that
I am booting the right image.

> 
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks,
Sekhar
