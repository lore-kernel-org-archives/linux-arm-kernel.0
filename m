From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Wed, 18 May 2016 09:53:48 +0100
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <CAKv+Gu_ekP+44FJjR7BY_MFqx2jQgc6Tk9W4SBL__ttdvQ55VQ@mail.gmail.com>
References: <20160218132824.GE2651@codeblueprint.co.uk>
 <CAKv+Gu-s1pzYBzuDG-Z7s3gyo8dPOfeidZQ+rim-uAWZCBcKQQ@mail.gmail.com>
 <20160218134324.GG2651@codeblueprint.co.uk>
 <CAKv+Gu875r9RkDC723kNsG4XC0eSE9RPPmSFZrD0sx0QxS+V4g@mail.gmail.com>
 <20160218141544.GH2651@codeblueprint.co.uk>
 <20160218191624.GA1515@redhat.com>
 <20160226144114.GA7475@codeblueprint.co.uk>
 <20160301233040.GA31476@codeblueprint.co.uk>
 <20160304062524.GA19010@dhcp-128-65.nay.redhat.com>
 <CAKv+Gu_ekP+44FJjR7BY_MFqx2jQgc6Tk9W4SBL__ttdvQ55VQ@mail.gmail.com>
Message-ID: <20160518085348.GG21993@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 May, at 10:36:33AM, Ard Biesheuvel wrote:
> 
> So what is the status here? I know Sai is working on x86 support for
> the memory attributes table, so it would make sense settle this matter
> as well.

This got stuck behind some other work, sorry about that.

Some of this was just merged by Linus (getting rid of the global
memmap and switching everyone over to efi.memmap), a large chunk
remains however.

I should be able to get those patches mailed out once the merge window
closes.
