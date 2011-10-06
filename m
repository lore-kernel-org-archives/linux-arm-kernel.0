From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 6 Oct 2011 13:51:27 +0530
Subject: [PATCH v6 07/16] OMAP2+: UART: Add default mux for all uarts.
In-Reply-To: <87zkhf9s4p.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-7-git-send-email-govindraj.raja@ti.com>
	<87zkhf9s4p.fsf@ti.com>
Message-ID: <CAAL8m4zuZ5qFJBdKqNxbw4ApKQ6WnTXiy4yFgOFeeG4H2mtCrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the review.

On Thu, Oct 6, 2011 at 12:34 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Prior to this change rx-pad wakeup was done by writing to rx-pad offset value
>> populated in serial.c idle_init. Now with mux framework support we can use
>> mux_utilities along with hmwod framework to handle io-pad configuration and
>> enable rx-pad wake-up mechanism.
>
> This patch (along with a few others) have compile errors when CONFIG_PM
> is not set.
>

Will check and fix this.

Please let me know on further comments on the series.

Will re-post fixing the same.

--
Thanks,
Govindraj.R


> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
