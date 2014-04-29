From: miklos@szeredi.hu (Szeredi Miklos)
Date: Tue, 29 Apr 2014 13:24:36 +0200
Subject: [RFC 3/3] asm-generic: Drop renameat syscall from default list
In-Reply-To: <CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
 <1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
 <201404231418.05174.arnd@arndb.de>
 <CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
Message-ID: <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 2:41 PM, James Hogan <james.hogan@imgtec.com> wrote:

> It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
> syscall to asm-generic unistd.h), and will be submitting it to Linus
> at some point as part of his renameat2 series.
> Miklos: Do you think it makes sense for you to include my second patch
> in your series too since it's renameat2 related?
> http://marc.info/?l=linux-kernel&m=139824773305016&w=2

I've queued up the first two patches with acks from Arnd.

Thanks,
Miklos
