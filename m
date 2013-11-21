From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 16:11:39 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131118151900.GF16735@n2100.arm.linux.org.uk>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <201311152056.47846.arnd@arndb.de> <20131115232109.GT16735@n2100.arm.
 linux.org.uk> <201311181605.37300.arnd@arndb.de> <20131118151900.GF16735@
 n2100.arm.linux.org.uk>
Message-ID: <20131121161139.529B5C406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 15:19:01 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> They are using strings which are the same as the DT properties, but
> without the vendor prefix - but yes, to only retrieve things like
> booleans, u32s and such like.  They also have support for fixed-rate
> clocks via the clk API too...
> 
> I'd like them to post the patches publically so a more open discussion
> could occur.

Indeed.

g.
