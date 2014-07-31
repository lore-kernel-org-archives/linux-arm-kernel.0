From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 31 Jul 2014 09:56:48 -0700
Subject: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
In-Reply-To: <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
References: <cover.1406604806.git.luto@amacapital.net>
 <20140729192056.GA6308@redhat.com>
 <CALCETrX6P7SJQdgc0gTM7FLdwyT_Ld1MWvkLYpTO_2xsvBC9sA@mail.gmail.com>
 <CALCETrXHF5YzPQDvnJs=mFNm2Ff_FekGu_Y8-JyMaWh2hctR7A@mail.gmail.com>
 <20140730165940.GB27954@localhost.localdomain>
 <CALCETrUafpWfnbfZzgu3qSGqyxcG0+6A=A1RE8g++=GrQKD93Q@mail.gmail.com>
Message-ID: <53DA7550.40905@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 10:25 AM, Andy Lutomirski wrote:
> 
> And yet x86_64 has this code implemented in assembly even in the
> slowpath.  Go figure.
> 

There is way too much assembly in entry_64.S probably because things
have been grafted on, ahem, "organically".  It is darn nigh impossible
to even remotely figure out what goes on in that file.

	-hpa
