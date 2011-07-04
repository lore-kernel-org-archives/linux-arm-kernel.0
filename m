From: govindraj.ti@gmail.com (Govindraj)
Date: Mon, 4 Jul 2011 10:38:55 +0530
Subject: [PATCH 2/2 v4] OMAP2+: hwmod: Add API to check IO PAD wakeup
	status
In-Reply-To: <alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
References: <1309603946-25395-1-git-send-email-govindraj.raja@ti.com>
	<1309603946-25395-3-git-send-email-govindraj.raja@ti.com>
	<alpine.DEB.2.00.1107021037040.8874@utopia.booyaka.com>
Message-ID: <CAAL8m4xRe7z3N=2t2o=JpXC6kLXU9WGsr4ujdHBCp_Uno2f1xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 2, 2011 at 10:07 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Sat, 2 Jul 2011, Govindraj.R wrote:
>
>> +int omap_hmwod_pad_get_wakeup_status(struct omap_hwmod *oh)
> ? ? ? ? ? ?^^^^^
>
> should be "hwmod"

corrected and re-posted both patches.

http://permalink.gmane.org/gmane.linux.ports.arm.omap/60250

http://permalink.gmane.org/gmane.linux.ports.arm.omap/60252

--
Thanks,
Govindraj.R


>
>
> - Paul
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
