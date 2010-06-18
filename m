From: eric.y.miao@gmail.com (Eric Miao)
Date: Fri, 18 Jun 2010 12:15:45 +0800
Subject: [Question] SuspendToDisk Feature on ARM ?
In-Reply-To: <AANLkTinXqVqe9xWQYj-CyzPHl9k7qAqxX6ueOqB3qTve@mail.gmail.com>
References: <AANLkTinXqVqe9xWQYj-CyzPHl9k7qAqxX6ueOqB3qTve@mail.gmail.com>
Message-ID: <AANLkTimmvPMG0GFEXfgFlXgC7V4dIWmW8vEC5gegsKSE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 10:08 PM, sumeet linux <sumeet4linux@gmail.com> wrote:
> Hi List,
>
> Does there exists a support for Suspend To Disk (Hibernate) for ARM
> platforms?
> I have been googling for it but could not find any information other than
> some links to the suspend2 support for some ancient kernels.
> Can anyone provide any clue on how much effort is required to implement this
> feature to ARM architecture ?
>

Marvell has done a great job on this for a preliminary enabling on their Dove
processor, please have a look into:

http://kernel.ubuntu.com/git?p=ubuntu/ubuntu-lucid.git;a=shortlog;h=refs/heads/mvl-dove

arch/arm/mach-dove/swsusp.S

The code, mostly, is generic enough to be made common if you are
interested and have other platforms (with HDD or large NAND) to
test. x86 is, of course, the reference.
