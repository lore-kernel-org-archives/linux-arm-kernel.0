From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Dec 2014 10:44:52 +0100
Subject: [PATCH v2 0/7] Pinctrl support for Zynq
In-Reply-To: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1417137993-8337-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkdbYPmMksbqciiXv4hHBqx9=b8toA5MgCwGSLteUh+NkZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 2:26 AM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> here is v2 of this series. On the functional side, adding the support
> for USB mux groups is probably the biggest change. Most other changes
> are mostly cosmetic (typos, function names, documentation, ...).
> More detailed changelogs are included with the respective patches.

Unfortunately we are late in the merge cycle.

But I am *very* fond of this series, and I appreciate your patches
as *lot* S?ren.

So my plan is to merge your v3 patch set after the merge window
or whenever you have it ready, with the Zynq driver on top and
the dependent AMlogic driver too.

Then we spend the next kernel cycle hashing this out and
putting some polished generic code in place so we get some
order.

This will likely set the pattern for how we expect ACPI pin controllers
to behave too, so it is work of great importance.

I hope I can count on you to hang in there and keep driving
those patches!

I'll try to provide a deeper look at the indivudual patches now.

Yours,
Linus Walleij
