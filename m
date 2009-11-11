From: papalagi.pakeha@gmail.com (Papalagi Pakeha)
Date: Wed, 11 Nov 2009 14:17:18 +1300
Subject: Runtime code modification fails on arm
In-Reply-To: <343d1bca0911101556x61fead12jb4113d1680228b8a@mail.gmail.com>
References: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
	<20091110191740.GA20317@n2100.arm.linux.org.uk>
	<343d1bca0911101556x61fead12jb4113d1680228b8a@mail.gmail.com>
Message-ID: <343d1bca0911101717u4f77f4bdi2f2f73e1efb8062c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 12:56 PM, Papalagi Pakeha
<papalagi.pakeha@gmail.com> wrote:
> However I can't find a ready to use
> cacheflush() implemented in glibc (2.3.3) or dietlibc.

... because it is called __clear_cache() and comes from libgcc. Oh
well, it took me only about 2 hrs to figure that out ;-)

Thanks for everyones help, my decryptor now seems to work.

PaPa
