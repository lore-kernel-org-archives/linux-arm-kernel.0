From: kernel@martin.sperl.org (Martin Sperl)
Date: Mon, 11 Jan 2016 14:57:46 +0100
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding
 documentation for bcm2835-aux-uart
In-Reply-To: <4288762.bCLxQBDvy4@wuerfel>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <10159898.8xe3rmYdEi@wuerfel>
 <175E89CE-581C-48AB-B7FF-6E9A41B033D5@martin.sperl.org>
 <4288762.bCLxQBDvy4@wuerfel>
Message-ID: <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 11.01.2016, at 13:21, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> Please just add another patch to rename the existing uarts appropriately
> first, then add this one on top with the correct name.

I can do that with the next incarnation of the patch.

But would that not break dt-source files, that refer to uart0?
Is this not considered an API change as well or does this only apply
to the binary files?
