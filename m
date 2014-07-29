From: davem@davemloft.net (David Miller)
Date: Tue, 29 Jul 2014 16:48:11 -0700 (PDT)
Subject: [PATCH 2/2] net: mvpp2: implement ioctl() operation for PHY ioctls
In-Reply-To: <1406496096-11039-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406496096-11039-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406496096-11039-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140729.164811.301176869068457588.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sun, 27 Jul 2014 23:21:36 +0200

> This commit implements the ->ndo_do_ioctl() operation so that the
> PHY-related ioctl() calls can work from userspace, which allows
> applications like mii-tool or mii-diag to do their job.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Applied.
