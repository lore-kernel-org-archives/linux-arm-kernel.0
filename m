From: deller@gmx.de (Helge Deller)
Date: Thu, 26 Jul 2018 14:59:40 +0200
Subject: [PATCH v4 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
References: <20180705110716.3919-1-alex@ghiti.fr>
 <20180709141621.GD22297@dhcp22.suse.cz>
 <2173685f-7f85-7acb-4685-2383210c5fa2@ghiti.fr>
 <87d0vehx16.fsf@concordia.ellerman.id.au>
 <67aba0f0-c0d4-b06f-5fbc-f4d113ce5033@ghiti.fr>
Message-ID: <20180726125940.GA15033@ls3530>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Alex Ghiti <alex@ghiti.fr>:
> This is the result of the build for all arches tackled in this series
> rebased on 4.18-rc6:
> ...
> parisc:
> ??????? generic-64bit_defconfig: with huge page does not link
> ??????? generic-64bit_defconfig: without huge page does not link
> ??????? BUT not because of this series, any feedback welcome.
Strange, but I will check that later....

Anyway, I applied your v4-patch to my parisc64 tree, built the kernel,
started it and ran some hugetlb LTP testcases sucessfully.
So, please add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Helge
