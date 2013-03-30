From: anton@enomsg.org (Anton Vorontsov)
Date: Sat, 30 Mar 2013 13:10:25 -0700
Subject: [PATCH 0/2] fix cns3xxx booting issue
In-Reply-To: <CAK1hUK9khvggwc_yaQUu61bTLaHZiAFowFGC-BH98Tp0zFaXZA@mail.gmail.com>
References: <CAK1hUK9khvggwc_yaQUu61bTLaHZiAFowFGC-BH98Tp0zFaXZA@mail.gmail.com>
Message-ID: <20130330201025.GA3069@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mac,

On Fri, Mar 29, 2013 at 05:13:01PM +0800, Mac Lin wrote:
> I'm sorry that I cannot send the patches via send-patch, nor can I
> make a new one now.
> So I'll copy-paste the result of format-patch. (I'm working on an
> unsupported Ubuntu.....)
> 
> > I have my code pushed to https://github.com/mkl0301/linux.git, branch
> > cns3v20vb-3.9-multiplatform-test, in case you need them.

Awesome! Thank you so much, Mac!

I did some cosmetic changes, plus rearranged the patches so that the main
fix can be propagated to the -stable series (and added Cc: stable, of
course). I will send pull request shortly.

Thanks again!

Anton
