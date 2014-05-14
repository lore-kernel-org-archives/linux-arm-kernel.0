From: james.hogan@imgtec.com (James Hogan)
Date: Wed, 14 May 2014 17:16:57 +0100
Subject: [RFC 3/3] asm-generic: Drop renameat syscall from default list
In-Reply-To: <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>	<1398247687-13453-4-git-send-email-james.hogan@imgtec.com>	<201404231418.05174.arnd@arndb.de>	<CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
 <CAELBmZB=74foyc_b-MTVOXeP6rVAD2x4=um2RVezTb68DifEbA@mail.gmail.com>
Message-ID: <537396F9.3090704@imgtec.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miklos,

On 29/04/14 12:24, Szeredi Miklos wrote:
> On Wed, Apr 23, 2014 at 2:41 PM, James Hogan <james.hogan@imgtec.com> wrote:
> 
>> It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
>> syscall to asm-generic unistd.h), and will be submitting it to Linus
>> at some point as part of his renameat2 series.
>> Miklos: Do you think it makes sense for you to include my second patch
>> in your series too since it's renameat2 related?
>> http://marc.info/?l=linux-kernel&m=139824773305016&w=2
> 
> I've queued up the first two patches with acks from Arnd.

Were you planning to send a pull request for your renameat2 patches for
v3.15?

Cheers
James
