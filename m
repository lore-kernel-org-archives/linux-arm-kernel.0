From: palmer@sifive.com (Palmer Dabbelt)
Date: Wed, 14 Nov 2018 10:06:24 -0800 (PST)
Subject: [PATCH v2 0/2] Introduce common code for risc-v sparsemem support
In-Reply-To: <20181107205433.3875-1-logang@deltatee.com>
Message-ID: <mhng-dfc065e5-80c6-4a9d-b95b-95170df42969@palmer-si-x1c4>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Nov 2018 12:54:31 PST (-0800), logang at deltatee.com wrote:
> These are the first two common patches in my series to introduce
> sparsemem support to RISC-V. The full series was posted last cycle
> here [1] and the latest version can be found here [2].
>
> As recommended by Palmer, I'd like to get the changes to common code
> merged and then I will pursue the cleanups in the individual arches (arm,
> arm64, and sh) as well as add the new feature to riscv.
>
> I would suggest we merge these two patches through Andrew's mm tree.

I haven't seen any review on this.  It looks fine to me, but I'm not qualified 
to review it as I don't really know anything about core MM stuff -- and I 
certainly don't feel comfortable taking this through my tree.

I've To'd linux-mm, hopefully it just got lost in the shuffle during the merge 
window.
