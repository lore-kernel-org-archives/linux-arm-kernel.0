From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Apr 2014 22:16:33 -0700
Subject: [ARM ATTEND] DeviceTree status
In-Reply-To: <CAL_JsqLe0s6iw_BuZg4B8RwByKSbVABLfTP9hiYhTfzvaaQp_A@mail.gmail.com>
References: <CAL_JsqLe0s6iw_BuZg4B8RwByKSbVABLfTP9hiYhTfzvaaQp_A@mail.gmail.com>
Message-ID: <CAOesGMjLzoxZXuc6qANe1DyVtPiw8q=hpJm8t34GNW3rqE6=0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Doing a generic reply on an old post, there's been many about DT though:

On Mon, Mar 24, 2014 at 7:55 AM, Rob Herring <robherring2@gmail.com> wrote:
> I will be attending ELC. I think I may be the only DT maintainer
> attending (the rest were too scared).
>
> For the ARM summit, I can give a summary of what's happened in DT land
> since the last ARM summit. There's been some good progress although
> probably not as much as anyone would like. Given the last summit, I'm
> sure there is more to discuss. If not, I'm available for beers to
> celebrate solving all the issues. ;)

I'm actually not excited about more discussion. There was a _ton_ of
it in Edinburgh, with many decisions done. Unless people have gone off
to actually try to implement some of the things we agreed need to be
implemented, and now need to come back with "it didn't work, we need
to change everything", then we shouldn't have to meet and spend
another mind-numbing day discussing DT. Or do we?

> A key question to discuss is: are DT binding reviews improving?

Hm. Do we need to meet in a room to talk about that, or can we discuss
it over email?

I would say that they have improved, in particular because we've
started seeing more DT changes go in (and more bindings). There are
some areas that are still difficult, and I think the answer for those
is to find the right people and sit down and hash it out. ELC is
probably a good venue for some of that, but doing it in a room full of
ARM kernel maintainers might not be.

> I also think the process for handling stable vs. unstable bindings
> needs more discussion. We also need to discuss how to deprecate
> existing "stable" bindings in order to have a way to stop new usage of
> poorly designed bindings we want to phase out.

Do you have a proposal and a process in mind? Having something
specific to start a discussion off of is more useful than opening it
up for round table talks.


-Olof
