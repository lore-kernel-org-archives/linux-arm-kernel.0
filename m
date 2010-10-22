From: tony@atomide.com (Tony Lindgren)
Date: Fri, 22 Oct 2010 10:21:20 -0700
Subject: [PATCH] ARM: OMAP: Modified omap_mux_init_signal() to take in
	const char *
In-Reply-To: <4CC09042.3000201@logicpd.com>
References: <1287687041-22377-1-git-send-email-tim.nordell@logicpd.com>
	<4CC09042.3000201@logicpd.com>
Message-ID: <20101022172120.GH9149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tim Nordell <tim.nordell@logicpd.com> [101021 12:02]:
>  On 10/21/10 13:50, Tim Nordell wrote:
> 
> It looks like by inspection that there could be a couple of things wrong
> with that patch however.  Namely, on the comparison of muxname to
> m0_entry, if they have the same string up to mode0_len, such as
> "dss_data1" and "dss_data12" it'd match there prematurely as it'd stop
> comparing.  Also, a minor display issue on the printk of the new muxname.

Good catch, it would be nice to get those fixed too. Got any patches
for those issues?

Regards,

Tony
