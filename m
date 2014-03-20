From: kamal@canonical.com (Kamal Mostafa)
Date: Thu, 20 Mar 2014 12:22:03 -0700
Subject: ARM memset fixes for 3.8.y.x extended
In-Reply-To: <CAGVrzcbR=o9Maj9YxFs2=-K0E21AWn9dDpSgHMFiGU-GjhLaWg@mail.gmail.com>
References: <CAGVrzcbR=o9Maj9YxFs2=-K0E21AWn9dDpSgHMFiGU-GjhLaWg@mail.gmail.com>
Message-ID: <1395343323.2770.79.camel@fourier>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-03-20 at 09:39 -0700, Florian Fainelli wrote:
> Hi Kamal,
> 
> Could you schedule the following two patches for the upcoming
> 3.8.13.20 stable release:
> 
> 418df63adac5 ARM: 7670/1: fix the memset fix
> 455bd4c430b0 ARM: 7668/1: fix memset-related crashes caused by recent
> GCC (4.7.2) optimizations


Sure.  These are now queued-up for 3.8.13.20.  Thanks Florian!

 -Kamal


> These two patches apply cleanly to linux-3.8.y-queue on top of
> 259e6d8c076a ("ACPI / video: Filter the _BCL table for duplicate
> brightness values").
> 
> Thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/d523a81b/attachment.sig>
