From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Mon, 16 Nov 2015 20:41:46 -0800
Subject: [PATCH V4 2/2] arm64: bpf: make BPF prologue and epilogue align
 with ARM64 AAPCS
In-Reply-To: <CABg9mcvh+SLK-1iF28pCQgXt5WM_H4tH3ntgKSkMHCyMygThgw@mail.gmail.com>
References: <CABg9mcvomep=M1As_Vj=XuTNk=jiGwXQqQWbjotMXP2csKX=Bg@mail.gmail.com>
 <1447713335-29707-1-git-send-email-yang.shi@linaro.org>
 <CABg9mcvh+SLK-1iF28pCQgXt5WM_H4tH3ntgKSkMHCyMygThgw@mail.gmail.com>
Message-ID: <20151117044145.GA71069@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 08:37:11PM -0800, Z Lim wrote:
> On Mon, Nov 16, 2015 at 2:35 PM, Yang Shi <yang.shi@linaro.org> wrote:
> > Save and restore FP/LR in BPF prog prologue and epilogue, save SP to FP
> > in prologue in order to get the correct stack backtrace.
...
> > CC: Zi Shen Lim <zlim.lnx@gmail.com>
> > CC: Xi Wang <xi.wang@gmail.com>
> > Signed-off-by: Yang Shi <yang.shi@linaro.org>
> 
> Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>

great that it's finalized.
Yang, please resubmit both patches to netdev as fresh submission so it
gets picked up by patchwork.
