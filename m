From: manchoyy@gmail.com (Man Choy)
Date: Tue, 14 Feb 2017 09:16:55 +0800
Subject: [PATCH] bcm2835-audio: Fix checkpatch errors
In-Reply-To: <20170213120340.GA25852@kroah.com>
References: <1486845362-25086-1-git-send-email-manchoyy@gmail.com>
 <20170212121658.GA19617@kroah.com>
 <CAExP5d4F-8mkcDjyNMYT0Kah11oGwbbg6hRaveOZuq065-2=Zg@mail.gmail.com>
 <20170213120340.GA25852@kroah.com>
Message-ID: <CAExP5d5nuqvYPoQuBLH89pKrREwaE=WyPrmBZrLSoCdYmMmYfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 8:03 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Feb 13, 2017 at 08:49:06AM +0800, Man Choy wrote:
>> A quick question, I just updated my linux-next tree last night,
>> checkout tag "next-20170210" and working on the cleanup. How do I
>> double check my current working file already been updated by someone
>> else to avoid the duplicate work? As of now, the latest linux-next
>> tree tag is still "next-20170210"
>
> linux-next is usually a day or so behind my tree, due to the time
> differences when it is created and why I usually do work.
>
> You can work off of my staging-next branch in my staging.git tree on
> git.kernel.org, that is the most up-to-date branch that ends up in
> linux-next.  I also use staging-testing, to test things, but I would not
> recommend that for you as it can be rebased and would be a pain to work
> against.
>
> It's ok that conflicts happen, that's how kernel development works,
> sometimes people send in the same change minutes from each other, so I
> have to take the one that was sent first.  It's ok, just move on and
> work on something else if you really want to.
>
>> I am on eudyptula challenge and this is my first attempt to send
>> kernel patch, sorry about the silly question ;)
>
> It's not silly, it comes up all the time.
>
> good luck!
>
> greg k-h

Thanks for the kind advice.

I will look up your staging-next branch and do something about it.

Talk to you soon.

- MC
