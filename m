From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 21:49:09 +0800
Subject: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
Message-ID: <20120202134907.GA3015@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 09:24:57AM -0200, Fabio Estevam wrote:
> Hi Richard,
> 
> On Thu, Feb 2, 2012 at 12:12 AM, Richard Zhao <richard.zhao@linaro.org> wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> > ?arch/arm/boot/dts/imx6q-sabrelite.dts | ? 12 ++++++++++++
> > ?1 files changed, 12 insertions(+), 0 deletions(-)
> 
> I would like to test your audio support patch on mx6sabrelite, but the
> missing sound/soc/imx-sgtl5000.c does not allow me to do it.
I have a test branch. I'll push to my linaro git  on git.linaro.org tomorrow.
> 
> I think you would better introduce sound/soc/imx-sgtl5000.c first (on
> separate patch series) so that people could test this patch without
> using the imx-sgtl5000.c implementation from the Linaro kernel.
> 
> Without imx-sgtl5000.c in place, this patch only introduces dead code
> at the moment.
Each patch make sense too without sgtl5000. 

Thanks
Richard
> 
> Regards,
> 
> Fabio Estevam
