From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 21 Aug 2018 09:26:12 -0300
Subject: Atmel AT91 support in mainstream kernel 4.4
In-Reply-To: <CAK3Qp=UAex-68+oCk4v6WOERHiWtB5CEqDtQJvGj+xv2GonOhg@mail.gmail.com>
References: <CAK3Qp=UAex-68+oCk4v6WOERHiWtB5CEqDtQJvGj+xv2GonOhg@mail.gmail.com>
Message-ID: <CAOMZO5DPg_A35ipXXvBHjRXv89uC4cDe=5v-6MW69BETt9AZ+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fernando,

On Tue, Aug 21, 2018 at 9:10 AM, Fernando AE <fernando.ae2017@gmail.com> wrote:
> Hello all,
>
> I'd like to know if AT91 boards (more specifically AT91SAM9G20) is
> well supported in mainstream Kernel 4.4.
>
> In more details, I'm working in a project of bringing up Linux 4.4 in
> a iMX6 based board, while trying to keep the same sources for our
> legacy AT91 based board. So, I'm wondering if it's a good idea to take
> Freescale's repo based on 4.4 as reference and compiling both for iMX
> and AT91.

There is no need to use the NXP provided kernel (there is no 4.4
kernel provided by NXP by the way - only 4.1 and 4.9).

You could use the latest mainline kernel instead for the two platforms.
