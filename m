From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 30 Nov 2016 10:17:30 -0600
Subject: [PATCH v2] PCI: Add information about describing PCI in ACPI
In-Reply-To: <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
References: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAADWXX_ipJ+pVmV5s2oLCKBrC5qUDASOZf=tpBfJWELExam+hQ@mail.gmail.com>
Message-ID: <20161130161730.GB13411@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2016 at 03:39:11PM -0800, Linus Torvalds wrote:
> Bjorn, this email was marked as spam, because:
> 
>   It has a from address in google.com but has failed google.com's
> required tests for authentication
> 
> in particular, it looks like you used a non-google smtp server
> (kernel.org) to send the email, so there is no DKIM hash (or perhaps
> google just uses some other non-standard marker for "this actually
> came from google"). So gmail marks it as spam because dmarc fails:
> 
>        dmarc=fail (p=REJECT dis=NONE) header.from=google.com
> 
> Just to let you know. If you use your google.com email, you do need to
> go through the google smtp server.
> 
> This may or may not be new - I didn't go and look at old messages of
> yours, but it is possible that google.com enabled dmarc/dkim recently.

Argh, thanks for letting me know.  Looks like I've had this broken for a
long time, but I didn't notice.  I think I have it fixed so git will record
the author as bhelgaas at google.com, but git/stgit will send email from
helgaas at kernel.org via the kernel.org smtp server.
