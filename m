From: joe@perches.com (Joe Perches)
Date: Thu, 22 May 2014 09:45:36 -0700
Subject: [PATCH] mfd: axp20x: Remove unnecessary const qualifier from
 axp20x_supplies[]
In-Reply-To: <20140522160856.GJ19747@lee--X1>
References: <1400750311-15323-1-git-send-email-lee.jones@linaro.org>
 <1400750311-15323-2-git-send-email-lee.jones@linaro.org>
 <1400774373.21099.1.camel@joe-AO725> <20140522160856.GJ19747@lee--X1>
Message-ID: <1400777136.21099.6.camel@joe-AO725>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-22 at 17:08 +0100, Lee Jones wrote:
> To be frank, I've never known what the double const means.  Care to
> enlighten?

There's a nice table here:

http://stackoverflow.com/questions/14562845/why-does-passing-char-as-const-char-generate-a-warning
