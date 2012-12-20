From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 20 Dec 2012 09:44:51 -0800
Subject: [GIT PULL v2] ARM: arm-soc fixes for 3.8
In-Reply-To: <20121220173548.GB4989@atomide.com>
References: <20121220163814.GA29557@quad.lixom.net>
 <CA+55aFxL47wxTyTzLdnoFV=trnrMAz=_7rhsQFjb+K_mvTCa9w@mail.gmail.com>
 <CAOesGMiZTF4gogCkU7eSaOydkX82wfWywkKBgCJo_-ZW0Ox4kw@mail.gmail.com>
 <20121220173548.GB4989@atomide.com>
Message-ID: <CA+55aFyhsXpB9-cS3-wbVojaTaiDq9jFe3bhbQrbzFpKHvMbJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 20, 2012 at 9:35 AM, Tony Lindgren <tony@atomide.com> wrote:
>
> Looks like Linus already applied "ARM: OMAP: Fix build breakage due
> to missing include in i2c.c" that I had queued earlier.

Yeah, since it was my mis-merge, and I realized that I had entirely
missed the header file fixup, I felt like I had to correct it since I
had the report and the pointer to the fix..

            Linus
