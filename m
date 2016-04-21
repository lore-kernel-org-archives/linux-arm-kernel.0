From: holgerschurig@gmail.com (Holger Schurig)
Date: Thu, 21 Apr 2016 14:11:19 +0200
Subject: [PATCH v2] drm/panel: simple: Add support for Innolux AT070TN92
In-Reply-To: <20160420134036.GA7470@ulmo.ba.sec> (Thierry Reding's message of
 "Wed, 20 Apr 2016 15:40:36 +0200")
References: <1461159435-16528-1-git-send-email-boris.brezillon@free-electrons.com>
 <20160420134036.GA7470@ulmo.ba.sec>
Message-ID: <877ffrp3fc.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:
> Applied, thanks.

I once read that this is the recommended way to go, instead of
specifying the timings in the device tree. Why is this so?  Any new
display just increases the .text size of the kernel unnessary.

Did this idea stem from the era where bootloaders like Barebox couldn't
modify the DT ad-hoc before handing it over to the kernel?
