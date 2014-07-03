From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 03 Jul 2014 20:36:36 +0200
Subject: [PATCH 2/2] mach-spear: fixed spear1340.c file
In-Reply-To: <CAPDOMVh0qyjq11kKaO2ndYhLW8j+dZyv3-c89BBcO1AxY+fiHQ@mail.gmail.com>
References: <1404354994-7478-1-git-send-email-xerofoify@gmail.com>
 <1404410691.16291.11.camel@x220>
 <CAPDOMVh0qyjq11kKaO2ndYhLW8j+dZyv3-c89BBcO1AxY+fiHQ@mail.gmail.com>
Message-ID: <1404412596.16291.30.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[I fixed the top posting.]

On Thu, 2014-07-03 at 14:08 -0400, Nick Krause wrote:
> On Thu, Jul 3, 2014 at 2:04 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > This patch, together with patch 1/2, basically moves a chunk of code
> > into a separate file, didn't it? If so, why did you split that move in
> > two patches?
>
> Yes it is and I did it in two patches in order to be more readable.

It makes it harder to understand the change (I had to _guess_ it was a
move). Moreover, depending on the order that these two patches would be
merged, we could end up with a chunk of code being either included twice
or not included at all, in some range of commits. Neither would be good.

> > And how does all this work without any changes to a Makefile?
>
> Furthermore I don't known Kconfig well enough to do the Makefile
> for the file I created.

Then I think you should, well, study the kernel build system before
submitting a change like this. And you can also ask a question or two to
get things going. (Not sure what the relevant list would be.)


Paul Bolle
