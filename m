From: john@szakmeister.net (John Szakmeister)
Date: Tue, 3 Jan 2012 18:53:50 -0500
Subject: Best kernel to use and some patches...
In-Reply-To: <201201032217.51399.marek.vasut@gmail.com>
References: <CAEBDL5VPv=qmUBp0EZcQSff5sbcb8RqH1JkoktF0Qqu-=1BsRQ@mail.gmail.com>
 <201201032217.51399.marek.vasut@gmail.com>
Message-ID: <CAEBDL5XrkMQ0YcFBgf0jTA8pu=J+vFk+CcVoQ8Gr+q4bnedeDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 3, 2012 at 4:17 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
[snip]
>> Also, we ran into a cache-flushing issue in the 2.6.34 kernel with the
>> MMC/SDCard subsystem. ?We're running 2.6.34, but the issue still
>> exists in 2.6.34.10. ?Are you still taking patches for that line?
>
> No, check stable kernel releases (hint: kernel.org, keyword "stable")

Interesting!  It was marked stable the last time I checked (which was
just before Christmas).  Turns out the last tag was June 26th, 2011,
so it just fell off that list recently.  Just to make sure I
understand, once a branch falls from the stable moniker on kernel.org,
patches are no longer accepted for the branch, correct?

I'm sorry for all of the questions, I just want to understand what the
general flow is, and what we should target so that bugs we fix can
make it back upstream.

Thanks!

-John
