From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 30 Aug 2012 11:09:49 -0300
Subject: [PATCH] clk: mxs: Register USB clocks for mx23
In-Reply-To: <CAOMZO5AME0NXarMF_rarYJeQ4-rGc+DpV7nvL4OeQj+LfkLLQw@mail.gmail.com>
References: <1340148392-9847-1-git-send-email-festevam@gmail.com>
 <20120620143830.GF2253@S2101-09.ap.freescale.net>
 <CAOMZO5AaLKN9bhuPRLJkA8ytiwVi_yrpwzL0mJAzf6VS4PSRLQ@mail.gmail.com>
 <20120806030014.GB22302@S2101-09.ap.freescale.net>
 <CAOMZO5AME0NXarMF_rarYJeQ4-rGc+DpV7nvL4OeQj+LfkLLQw@mail.gmail.com>
Message-ID: <CAOMZO5CZjOopAy1EhWOOCszgJQNW52Z-UPjzVwU6MAp_HtDCzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Aug 13, 2012 at 12:06 AM, Fabio Estevam <festevam@gmail.com> wrote:
> Shawn,
>
> On Mon, Aug 6, 2012 at 12:00 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>
>> Probably, no, as I plan to freeze the addition to clkdev lookup table
>> and replace it with DT clock lookup.
>
> Could you please suggest how can I register the USB clocks for mx23?
> Any example I can refer to implement a "DT clock lookup"?

Ping?

I saw some patches from you that changes the way dt clocks are
registered for mx23/mx28, but not sure if these were applied or not.

Please let me know how should I proceed regarding mx23 usb clocks registration.

Regards,

Fabio Estevam
