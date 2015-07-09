From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 09 Jul 2015 10:32:46 +0200
Subject: [PATCH 1/7] pinctrl: UniPhier: add UniPhier pinctrl core support
In-Reply-To: <CAK7LNARqsxrFhSEOiZw7TYSyFR8vhaZYcK6KbuG84mP2eM5NJw@mail.gmail.com>
References: <1436185763-4308-1-git-send-email-yamada.masahiro@socionext.com>
 <1436185763-4308-2-git-send-email-yamada.masahiro@socionext.com>
 <1436260472.20057.121.camel@tiscali.nl>
 <CAK7LNASnaN47cPHyyH-DTrF4pE4XqhgUdZLuOspuqHtKoDxmRQ@mail.gmail.com>
 <1436387996.20619.54.camel@tiscali.nl>
 <CAK7LNARqsxrFhSEOiZw7TYSyFR8vhaZYcK6KbuG84mP2eM5NJw@mail.gmail.com>
Message-ID: <1436430766.20619.91.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,

On do, 2015-07-09 at 14:32 +0900, Masahiro Yamada wrote:
> After I read your references and thought a bit more,
> I am now considering to change the bool into tristate.
> 
> [...]
> 
> Is this OK with you?

Whether this should be bool or tristate is up to you and the maintainer
(Linus?). I just prefer if you'd be consistent with that choice (ie, you
should not use module specific code in a built-in only driver).

Thanks,


Paul Bolle
