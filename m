From: mmarek@suse.cz (Michal Marek)
Date: Thu, 18 Jul 2013 11:22:24 +0200
Subject: [PATCH] arm, kbuild: make "make install" not depend on vmlinux
In-Reply-To: <CA+55aFzhmV7iq+Pv37trMCmdNzk53ORAoj0a6rV14fzKta3Dhw@mail.gmail.com>
References: <20130710133742.GA29368@emu.suse.cz>
 <CA+55aFxtvT3Yvbxe5JGBThZS13payymFJ7jCLyEiE2iNDvsZtQ@mail.gmail.com>
 <20130711135445.GA21500@sepie.suse.cz>
 <CA+55aFyVjugxM7cUDWi0ASWttYthCxa6e7X3CADknBcSFxWgew@mail.gmail.com>
 <20130712105721.GF8731@rric.localhost> <20130717160506.GI8731@rric.localhost>
 <CA+55aFx4G5gME3ByqE0Wr-_t2x_6WkP3Ta4k1z4jfW+PrcK0og@mail.gmail.com>
 <20130717165743.GK8731@rric.localhost>
 <CA+55aFzhmV7iq+Pv37trMCmdNzk53ORAoj0a6rV14fzKta3Dhw@mail.gmail.com>
Message-ID: <51E7B3D0.4060609@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.7.2013 19:03, Linus Torvalds wrote:
> On Wed, Jul 17, 2013 at 9:57 AM, Robert Richter <rric@kernel.org> wrote:
>>
>> If kernel.release doen't exist KERNEL_RELEASE is empty, thus all args
>> for install.sh shift one arg left.
> 
> You know what? I read the patch, but I didn't read your changelog well
> enough. You already explained that in the commit log, and I just
> missed it like some blind monkey. My bad.
> 
>> Will splitt the patches and resend.
> 
> No need to split, I was wrong, it wasn't some unrelated cleanup, and
> you were right the first time.
> 
> So Michal (or ARM people - whoever wants to take the patch), just take
> my ack. No objections.

I can add it to the kbuild tree if needed. Otherwise you can add
Acked-by: Michal Marek <mmarek@suse.cz>.

Michal
