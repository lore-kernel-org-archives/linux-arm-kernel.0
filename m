From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Tue, 29 Nov 2016 15:39:11 -0800
Subject: [PATCH v2] PCI: Add information about describing PCI in ACPI
In-Reply-To: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bjorn, this email was marked as spam, because:

  It has a from address in google.com but has failed google.com's
required tests for authentication

in particular, it looks like you used a non-google smtp server
(kernel.org) to send the email, so there is no DKIM hash (or perhaps
google just uses some other non-standard marker for "this actually
came from google"). So gmail marks it as spam because dmarc fails:

       dmarc=fail (p=REJECT dis=NONE) header.from=google.com

Just to let you know. If you use your google.com email, you do need to
go through the google smtp server.

This may or may not be new - I didn't go and look at old messages of
yours, but it is possible that google.com enabled dmarc/dkim recently.

             Linus

On Tue, Nov 29, 2016 at 1:39 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Here's another stab at this writeup.  I'd appreciate any comments!
