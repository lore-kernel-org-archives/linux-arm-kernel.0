From: govindraj.ti@gmail.com (Govindraj)
Date: Wed, 9 Mar 2011 17:36:12 +0530
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
	requested pads
In-Reply-To: <alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com>
	<AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
	<alpine.DEB.2.00.1103081220140.10981@utopia.booyaka.com>
Message-ID: <AANLkTin6kv7apsWtGUubDRcH5JAfL0Kx5cDi5GQjKU1q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 9, 2011 at 12:51 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> By the way, if your patch relies on OMAP_DEVICE_PAD_IDLE, you should
> probably sync up with Sricharan, who is apparently planning to remove that
> flag:
>

currently I am dependent on OMAP_DEVICE_PAD_WAKEUP flag.
I am not using OMAP_DEVICE_PAD_IDLE as of now.

--
Thanks,
Govindraj.R


> ? http://www.mail-archive.com/linux-omap at vger.kernel.org/msg46296.html
>
>
> - Paul
>
