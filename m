From: richardcochran@gmail.com (Richard Cochran)
Date: Thu, 24 May 2012 09:10:47 +0200
Subject: [PATCH] ixp4xx: fix compilation by adding gpiolib support
In-Reply-To: <20120523181829.GK21608@burratino>
References: <1337789991-5283-1-git-send-email-richardcochran@gmail.com>
 <20120523172703.GI21608@burratino>
 <20120523181829.GK21608@burratino>
Message-ID: <20120524071046.GD2180@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2012 at 01:18:29PM -0500, Jonathan Nieder wrote:
> Quick correction: looks like[*] 3.1 is also affected due to
> 58c244009ef6 ("Input: ads7846 - cleanup GPIO initialization").  Sorry
> I missed that before.

...

> Hope that helps,

Yes, it does. I appreciate your effort in testing this on the older
versions.

Thanks,
Richard
