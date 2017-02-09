From: leoli@freescale.com (Li Yang)
Date: Thu, 9 Feb 2017 17:12:28 -0600
Subject: [PATCH 1/2] net: ethernet: ucc_geth: fix MEM_PART_MURAM mode
In-Reply-To: <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
References: <cover.1486456900.git.christophe.leroy@c-s.fr>
 <d25ee7a13b60dcd005c59169feacb18fb69a06c1.1486456900.git.christophe.leroy@c-s.fr>
Message-ID: <CADRPPNQaU5an0ituEB62GddFK6_mR4Y7n=yOOypUfSUdMsGsLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 7, 2017 at 3:05 AM, Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Since commit 5093bb965a163 ("powerpc/QE: switch to the cpm_muram
> implementation"), muram area is not part of immrbar mapping anymore
> so immrbar_virt_to_phys() is not usable anymore.
>
> Fixes: 5093bb965a163 ("powerpc/QE: switch to the cpm_muram implementation)
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Acked-by: Li Yang <pku.leo@gmail.com>

Regards,
Leo
