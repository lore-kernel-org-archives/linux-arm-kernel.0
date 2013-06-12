From: olof@lixom.net (Olof Johansson)
Date: Wed, 12 Jun 2013 16:54:55 -0700
Subject: [GIT PULL 0/6] Samsung stuff for v3.11
In-Reply-To: <51B791C3.7050702@samsung.com>
References: <51B791C3.7050702@samsung.com>
Message-ID: <20130612235455.GD9067@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 12, 2013 at 06:08:19AM +0900, Kukjin Kim wrote:
> Hi Arnd, Olof
> 
> Please pull Samsung stuff for v3.11.
> 
> If any problems, please kindly let me know.

Hi,

I've pulled 1, 2, 4 and 6. Please fix the comments on 3 and 5 and send fresh
requests.

Also, I see you've based a bunch of branches on -rc5. While this is
fine, it is more convenient for us to review your branch submission if it
doesn't also pull in a newer upstream -rc.

Main reason to use the most-recent -rc would be if new code conflicts
with fixes in the previous -rc version, but if they don't then feel free
to start your branches on an older version instead.


-Olof
