From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Mon, 06 Aug 2012 23:05:07 +0400
Subject: [PATCH] initramfs: handle trailing junk after valid image
In-Reply-To: <20120806093251.0528E77A0D@aristotle.killerwolves.net>
References: <CAB9O=CMADa26benQCkEoLOKKTGNeExjvFeVkFe4HLVi-W=o=Jg@mail.gmail.com>,
 <501F8D75.8070108@killerwolves.net>
 <20120806093251.0528E77A0D@aristotle.killerwolves.net>
Message-ID: <50201563.2020509@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/06/2012 01:32 PM, Ben Peddell wrote:

> The initramfs handling since commit df37bd15 has been rejecting

   Please also specify the summary of that commit in parens.

> valid images that have garbage after them.  For example, on an
> architecture where the initramfs address and size are specified
> as a kernel parameter (specifically unicore32 and arm), specifying
> e.g. initrd=0x01000000,4M will not work unless the image is padded
> with nulls to 4MiB.  This is unlikely to occur if the user is using
> this parameter to work around a bug in the bootloader.

   You didn't sign off the patchs, so it can't br applied.

WBR, Sergei
