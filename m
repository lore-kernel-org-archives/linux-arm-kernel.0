From: olof@lixom.net (Olof Johansson)
Date: Fri, 19 Apr 2013 07:01:28 -0700
Subject: linux-next: build failure after merge of the arm-soc tree
In-Reply-To: <20130419164636.0d2405ca5fd927f1ba31fe40@canb.auug.org.au>
References: <20130419164636.0d2405ca5fd927f1ba31fe40@canb.auug.org.au>
Message-ID: <CAOesGMhUTyPdNo=yaRqEv+Zhf7ga8e-R0asbnuje_LioWbqsgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:46 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the arm-soc tree, today's linux-next build (powerpc ppc64_defconfig)
> failed like this:
>
> powerpc64-linux-ld: cannot find drivers/pci/host/built-in.o: No such file or directory
>
> Caused by commit 9ecbe03ae85b ("pci: infrastructure to add drivers in
> drivers/pci/host").
>
> I have used the arm-soc tree from next-20130418 for today.

Sorry about that, I'll drop the branch that brought in the of_pci
consolidation from our repo.


-Olof
