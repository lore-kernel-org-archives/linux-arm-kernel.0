From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Mon, 30 Sep 2013 18:31:39 +0200
Subject: [PATCH] arm, kbuild: make "make install" not depend on vmlinux
In-Reply-To: <20130930084945.GA1963@rric.localhost>
References: <CA+55aFxtvT3Yvbxe5JGBThZS13payymFJ7jCLyEiE2iNDvsZtQ@mail.gmail.com>
 <20130711135445.GA21500@sepie.suse.cz>
 <CA+55aFyVjugxM7cUDWi0ASWttYthCxa6e7X3CADknBcSFxWgew@mail.gmail.com>
 <20130712105721.GF8731@rric.localhost>
 <20130717160506.GI8731@rric.localhost>
 <CA+55aFx4G5gME3ByqE0Wr-_t2x_6WkP3Ta4k1z4jfW+PrcK0og@mail.gmail.com>
 <20130717165743.GK8731@rric.localhost>
 <CA+55aFzhmV7iq+Pv37trMCmdNzk53ORAoj0a6rV14fzKta3Dhw@mail.gmail.com>
 <51E7B3D0.4060609@suse.cz> <20130930084945.GA1963@rric.localhost>
Message-ID: <20130930163139.GA12450@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert, All,

On 2013-09-30 10:49 +0200, Robert Richter spake thusly:
> On 18.07.13 11:22:24, Michal Marek wrote:
> > > So Michal (or ARM people - whoever wants to take the patch), just take
> > > my ack. No objections.
> > 
> > I can add it to the kbuild tree if needed. Otherwise you can add
> > Acked-by: Michal Marek <mmarek@suse.cz>.
> 
> This didn't make it upstream yet, can somebody at it to a tree?

Since it's been acked-by Linus, I'll queue it in my tree, for Michal to
pull from. Expect a pull-request soon.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
