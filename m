From: nm@ti.com (Nishanth Menon)
Date: Tue, 29 Jan 2013 23:48:14 -0600
Subject: [RFC PATCH v2 1/2] ARM: kernel: update cpuinfo to print SoC model
 name
In-Reply-To: <1359506337-21619-2-git-send-email-ruslan.bilovol@ti.com>
References: <1359506337-21619-1-git-send-email-ruslan.bilovol@ti.com>
 <1359506337-21619-2-git-send-email-ruslan.bilovol@ti.com>
Message-ID: <CAGo_u6pvU0ZMJ0C-3pqW3-Sx87_o5_JM0HDT9eb_yxe+h_SiJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 6:38 PM, Ruslan Bilovol <ruslan.bilovol@ti.com> wrote:
>
> SoC name        : OMAP4470 ES1.0 HS
I am sorry, but I have to NAK for specifically reasons explained in
http://marc.info/?l=linux-omap&m=135950276616961&w=2

I just dont think SoC information belongs in /proc/cpuinfo. nor is SoC
name "OMAP4470 ES1.0 HS" -> it is just OMAP4470.

Regards,
Nishanth Menon
