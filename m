From: richardcochran@gmail.com (Richard Cochran)
Date: Wed, 16 Mar 2011 15:26:03 +0100
Subject: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
In-Reply-To: <cover.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
Message-ID: <20110316142603.GC12435@riccoc20.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 08:57:03AM +0100, Richard Cochran wrote:
> * PHC Patch ChangeLog
> ** v12
> *** gianfar_ptp
>    - fixed up device tree
>    - inlined the header file
>    - use platform_ calls instead of deprecated of_ calls
>    - removed static global single instance
>    - removed John Stultz's ack from this patch

@Thomas and John:

Can I get your acks on the remaining patches?

Can this be merged for 2.6.39?

Thanks,

Richard
