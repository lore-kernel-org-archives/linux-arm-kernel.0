From: ijc@debian.org (Ian Campbell)
Date: Tue, 03 Jul 2018 09:46:18 +0100
Subject: [RFC/RFT PATCH 0/2] disable_hest quirk on HP m400 with bad UEFI
 firmwware
In-Reply-To: <CAKv+Gu8OkHZJL8FXhsfQP8JodWLTFg5kz4wVcDPVWTs-29buug@mail.gmail.com>
References: <20180628100656.10692-1-james.morse@arm.com>
 <CAKv+Gu9ZHAGzcfgHShM1qvZ3qf4gb1pD_XfoceJu9Qy+5_pEsg@mail.gmail.com>
 <ef039f0c-dea2-80d7-e6fa-481f3452a600@infradead.org>
 <CAKv+Gu8OkHZJL8FXhsfQP8JodWLTFg5kz4wVcDPVWTs-29buug@mail.gmail.com>
Message-ID: <1530607578.9841.126.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-28 at 22:56 +0200, Ard Biesheuvel wrote:
> But that does not make it an upstream problem. The fact that this is
> an EOL platform of which only a couple of hundred are in circulation,
> combined with the fact that there is a trivial workaround available
> (the command line option) makes it a non-issue in my opinion,
> especially given the fact that not a single distro ships pristine
> mainline kernels, and so they can carry the quirk themselves.

I think that's rather unfortunate given that many distros (Debian
included, AIUI Fedora too, I'm sure others) try to ship kernels as
close to mainline as possible and the general steer from the kernel
community to try and do so whenever possible, to track stable releases
early and often etc.

Ian.
