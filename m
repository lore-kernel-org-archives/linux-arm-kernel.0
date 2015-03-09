From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 09 Mar 2015 19:47:12 +0100
Subject: [PATCH v5 6/8] pinctrl: cygnus: add gpio/pinconf driver
In-Reply-To: <CACRpkdbG3t3QEobibbf7wquTtCRm=B0qwivoAp9FTkYpYNL9JA@mail.gmail.com>
References: <1425515756-321-1-git-send-email-rjui@broadcom.com>
 <1425515756-321-7-git-send-email-rjui@broadcom.com>
 <1425543104.24292.185.camel@x220> <1425544581.24292.194.camel@x220>
 <54F88EB8.3020208@broadcom.com>
 <CACRpkdbG3t3QEobibbf7wquTtCRm=B0qwivoAp9FTkYpYNL9JA@mail.gmail.com>
Message-ID: <1425926832.2317.16.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij schreef op ma 09-03-2015 om 17:41 [+0100]:
> As pointed out in another mail on similar subject, I think these macros
> are a kind of obsolete documentation and if they should be dropped we
> need to go over an entire subsystem at a time and remove all boolean users
> in a big patch.

And, as I stated in that other thread, we could start by first checking
for things like this during review. (And if people were to do clean up
patches I'd suggest to do them one driver at a time. Just to keep things
manageable.)


Paul Bolle
