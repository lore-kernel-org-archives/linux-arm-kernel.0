From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Fri, 27 Nov 2015 21:21:55 +0000
Subject: [PATCH v3 13/13] ARM: add UEFI stub support
In-Reply-To: <CAKv+Gu_RC5qG=BGPSEf=j7AV4SbjXELjBxmcboj1oVs-Dn87qw@mail.gmail.com>
References: <1448269593-20758-1-git-send-email-ard.biesheuvel@linaro.org>
 <1448269593-20758-14-git-send-email-ard.biesheuvel@linaro.org>
 <20151126104711.GH2765@codeblueprint.co.uk>
 <CAKv+Gu_RC5qG=BGPSEf=j7AV4SbjXELjBxmcboj1oVs-Dn87qw@mail.gmail.com>
Message-ID: <20151127212155.GC13918@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Nov, at 10:38:05AM, Ard Biesheuvel wrote:
> 
> Actually, it is the reservation done a bit earlier that could
> potentially end up at 0x0, and the [compressed] kernel is always at
> least 32 MB up in memory, so that it can be decompressed as close to
> the base of DRAM as possible.
> 
> As far as I can tell, efi_free() deals correctly with allocations at
> address 0x0, and that is the only dealing we have with the
> reservation. So I don't think there is an issue here.

OK, great.
