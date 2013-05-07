From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 7 May 2013 20:41:37 +0200
Subject: [GIT PULL 0/5] ARM: Third batch of arm-soc changes for 3.10, again
In-Reply-To: <CA+55aFxJB3OG+-tu2SqAOzn9T7zDb0P9jgbUOMHnXs9m_nXNUA@mail.gmail.com>
References: <1367947574-2934383-1-git-send-email-arnd@arndb.de>
 <CA+55aFxJB3OG+-tu2SqAOzn9T7zDb0P9jgbUOMHnXs9m_nXNUA@mail.gmail.com>
Message-ID: <201305072041.37493.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 May 2013, Linus Torvalds wrote:
> On Tue, May 7, 2013 at 10:26 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > Here are the same pull requests as before, with numbers and distinct
> > time stamps. I hope I didn't screw up in a different way this time.
> 
> Ok, I notice that you seem to have forgotten the "--summary" flag from
> your diffstat in your new script.
> 
> Not a showstopper, but make sure that the diffstat flags are
> 
>   "git diff -M --stat --summary"
> 
> (And yes, I prefer "-M", not "-C", because while copy information is
> interesting, it tends to hide the fact that the copying added a lot of
> lines, so the "-C" flag ends up not giving as good line add/del
> information, even if the data that something looks like a copy of
> another file is interesting).

Right, another thing that I actually knew and then forgot to do. Olof
has just sent me the script he used the past few times, I'll use that
in the future.

	Arnd
