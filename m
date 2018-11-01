From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Nov 2018 11:49:08 +0100
Subject: [PATCH v3 0/7] Standardize onboard LED support for 96Boards
In-Reply-To: <CACRpkdarkLuErC_F4ALqOB5Wuf7TnDXmWZVKvfR7iGvOy=j++g@mail.gmail.com>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <CAHTX3dJTXtuA0i-ffPjoiWuxEcF_5JY55VJtWd9zxW4HxK1K3w@mail.gmail.com>
 <CACRpkdarkLuErC_F4ALqOB5Wuf7TnDXmWZVKvfR7iGvOy=j++g@mail.gmail.com>
Message-ID: <1590147.nMxYQPWRVN@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 31. Oktober 2018, 22:17:29 CET schrieb Linus Walleij:
> On Wed, Oct 31, 2018 at 4:47 PM Michal Simek <monstr@monstr.eu> wrote:
> > No doubt about it that this is good. If this is there from day 1 all will
> > be good. I am just saying that we are all the time
> > saying that we shouldn't break userspace. Right now if there is single
> > application which uses existing names we are breaking it.
> 
> Yeah that's the problem, the approach is usually that if a tree falls
> in the forest and noone is there to hear it, then it doesn't make a
> sound.
> 
> But we can't assume someone is there as the safe default either.
> 
> I'd say apply it and see what happens, people are supposed to test.

At least for the Rockchip boards I'm somewhat confident, that they should
be new enough to not have anybody building cludges - especially as I think
LEDs might not be the most interesting device on such boards :-) .

So while I can apply the Rockchip patches, I'm still hoping for some
kind of consensus beforehand, least we roll it back after the fact  ;-) .

Heiko
