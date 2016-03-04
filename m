From: dyoung@redhat.com (Dave Young)
Date: Fri, 4 Mar 2016 14:25:24 +0800
Subject: [PATCH v2 1/2] efi: esrt: use memremap not ioremap to access
 ESRT table in memory
In-Reply-To: <20160301233040.GA31476@codeblueprint.co.uk>
References: <20160218104407.GC2651@codeblueprint.co.uk>
 <CAKv+Gu_AW7PKJJOd2mbEu3LKJe+gNaPHnH=sgO=YXM_KWFyKxw@mail.gmail.com>
 <20160218132824.GE2651@codeblueprint.co.uk>
 <CAKv+Gu-s1pzYBzuDG-Z7s3gyo8dPOfeidZQ+rim-uAWZCBcKQQ@mail.gmail.com>
 <20160218134324.GG2651@codeblueprint.co.uk>
 <CAKv+Gu875r9RkDC723kNsG4XC0eSE9RPPmSFZrD0sx0QxS+V4g@mail.gmail.com>
 <20160218141544.GH2651@codeblueprint.co.uk>
 <20160218191624.GA1515@redhat.com>
 <20160226144114.GA7475@codeblueprint.co.uk>
 <20160301233040.GA31476@codeblueprint.co.uk>
Message-ID: <20160304062524.GA19010@dhcp-128-65.nay.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I have a very rough draft of patches that implement this strategy on
> the 'experiemntal/efi-memmap' branch in the EFI tree if anyone is
> curious and wants to take a look. The series will be sent out soon.
> 
> I wouldn't necessarily try running them or anything as there's a few
> things that I know are broken; ia64 build, EFI mixed mode boot,
> probably arm64 regressions.

Matt, I tried :). I see a build warning about print phys_addr_t without
%pa anotation and booting with ioremap error messages about slot not found
, and ioremap region leak messages.

Looking forward to your formal posts.

Thanks
Dave
