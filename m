From: cavokz@gmail.com (Domenico Andreoli)
Date: Thu, 31 Oct 2013 16:19:50 +0100
Subject: [PATCH 08/11] ARM: u300: use the common machine reset handling
In-Reply-To: <CACRpkdbzmqGpQKf5Mz7tKfRAuTNWV+WYSuerNFQOAsgdUOaoTg@mail.gmail.com>
References: <20131031062708.520968323@linux.com>
 <20131031063000.361406973@linux.com>
 <CACRpkdbzmqGpQKf5Mz7tKfRAuTNWV+WYSuerNFQOAsgdUOaoTg@mail.gmail.com>
Message-ID: <20131031151950.GA16491@glitch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 07:40:25AM -0700, Linus Walleij wrote:
> On Wed, Oct 30, 2013 at 11:27 PM, Domenico Andreoli
> <domenico.andreoli@linux.com> wrote:
> 
> > From: Domenico Andreoli <domenico.andreoli@linux.com>
> >
> > Proof of concept: u300 as provider of reset hooks.
> 
> Do you have a u300 to test this on or are you just guessing?

I don't have any u300, I picked it randomly. It's just to show some usage
and possibly discuss it. There are quite a lot of these hooks all around.

> Anyway, concept looks correct, so Acked-by given that the
> overall idea is accepted.

uhm.. don't see any general acceptance right now. maybe later..

thanks,
Domenico
