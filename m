From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 27 Feb 2017 10:49:04 -0600
Subject: [PATCH 2/4] PCI: add driver for Cortina Gemini Host Bridge
In-Reply-To: <CACRpkdZ1ONM-sODoYi4isk65Eq5GUqPtfqnL9=is5s0=zObm_w@mail.gmail.com>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-2-linus.walleij@linaro.org>
 <20170131003751.GF20550@bhelgaas-glaptop.roam.corp.google.com>
 <CACRpkdZ1ONM-sODoYi4isk65Eq5GUqPtfqnL9=is5s0=zObm_w@mail.gmail.com>
Message-ID: <20170227164903.GC11162@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 26, 2017 at 08:42:51PM +0100, Linus Walleij wrote:
> On Tue, Jan 31, 2017 at 1:37 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > Looks nice; a couple unused definitions below.
> 
> Just so I do things right:  what is your policy on unused defines?
> I'm asking because the defines in this case is pretty much the
> documentation... there is no datasheet for this IP core. I usually
> like to keep the defines around so people can have them as a
> hint if they want to tinker and hack the driver.
> 
> Would you be OK with keeping them if I comment them out?

It's fine if you keep them; don't even bother commenting them out.

If there's a datasheet, especially a public one like the PCI specs (I
know even those aren't completely free), I have been removing unused
defines simply because they can't be tested and there may be
transcription errors.  But I'm starting to think that might be too
aggressive.

Bjorn
