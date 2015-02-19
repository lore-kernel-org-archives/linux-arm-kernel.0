From: simon.budig@kernelconcepts.de (Simon Budig)
Date: Thu, 19 Feb 2015 13:16:52 +0100
Subject: [beagleboard] Kernel 3.14 vs 3.19
In-Reply-To: <6c26ff68-fd87-42d0-872f-637410a00dee@googlegroups.com>
References: <54A1B372.8080803@steinkuehler.net>
 <CAOCHtYgyyGq_DYsOjCf7AYv-Xdf1w1_qPxK06pHBB=k1vewDMA@mail.gmail.com>
 <6c26ff68-fd87-42d0-872f-637410a00dee@googlegroups.com>
Message-ID: <54E5D434.4090407@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/15 12:01, Elias Bakken wrote:
> Robert, now that 3.19 is released, do you have any plans for making it
> work?
> I'd love to see a 3.19 kernel for Debian :)

For the records: vanilla 3.19 works with the beaglebone. I did not test
extensively (and especially have ignored networking) but in general it
works.

I have updated the patch series from Andre Heider <a.heider@gmail.com>
for bbb-support of the uio-pruss driver against 3.19. It seems to work
ok for me. I have not yet tried to incorporate the feedback given in the
original thread:

   http://www.spinics.net/lists/linux-omap/msg108763.html

Since I am unsure how to send patches to the mailinglist which are
originially from an other author I have prepared a mbox-file and have
put it online:

   http://www.home.unix-ag.org/simon/files/uio-pruss-3.19.mbox

I hope this helps.

Bye,
        Simon

-- 
       Simon Budig                        kernel concepts GmbH
       simon.budig at kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150219/05b0f864/attachment.sig>
