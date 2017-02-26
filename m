From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 26 Feb 2017 20:42:51 +0100
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <20170131003751.GF20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
 <20170131003751.GF20550@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CACRpkdZ1ONM-sODoYi4isk65Eq5GUqPtfqnL9=is5s0=zObm_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 1:37 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:

> Looks nice; a couple unused definitions below.

Just so I do things right:  what is your policy on unused defines?
I'm asking because the defines in this case is pretty much the
documentation... there is no datasheet for this IP core. I usually
like to keep the defines around so people can have them as a
hint if they want to tinker and hack the driver.

Would you be OK with keeping them if I comment them out?

I'll repost the driver soon, including all things asked to be
fixed up by you & Arnd.

Yours,
Linus Walleij
