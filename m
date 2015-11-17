From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 17 Nov 2015 09:32:26 -0800
Subject: [PATCH v4 05/24] misc: max77693-haptic: use pwm_get_xxx()
 helpers where appropriate
In-Reply-To: <1447664207-24370-6-git-send-email-boris.brezillon@free-electrons.com>
References: <1447664207-24370-1-git-send-email-boris.brezillon@free-electrons.com>
 <1447664207-24370-6-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20151117173226.GA29423@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 09:56:28AM +0100, Boris Brezillon wrote:
> Use pwm_get_xxx() helpers instead of directly accessing the pwm->xxx field.
> Doing that will ease adaptation of the PWM framework to support atomic
> update.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Could you please tag input-related bits with "Input: driver - ... "
instead of "misc: ... "?

Thanks!

-- 
Dmitry
