From: lcapitulino@redhat.com (Luiz Capitulino)
Date: Tue, 31 Jul 2018 16:06:40 -0400
Subject: [PATCH v5 00/11] hugetlb: Factorize hugetlb architecture
 primitives
In-Reply-To: <20180731060155.16915-1-alex@ghiti.fr>
References: <20180731060155.16915-1-alex@ghiti.fr>
Message-ID: <20180731160640.11306628@doriath>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 Jul 2018 06:01:44 +0000
Alexandre Ghiti <alex@ghiti.fr> wrote:

> [CC linux-mm for inclusion in -mm tree] 
> 
> In order to reduce copy/paste of functions across architectures and then
> make riscv hugetlb port (and future ports) simpler and smaller, this
> patchset intends to factorize the numerous hugetlb primitives that are
> defined across all the architectures.

[...]

>  15 files changed, 139 insertions(+), 382 deletions(-)

I imagine you're mostly interested in non-x86 review at this point, but
as this series is looking amazing:

Reviewed-by: Luiz Capitulino <lcapitulino@redhat.com>
