From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 2 Feb 2012 22:41:18 +0800
Subject: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <CAOMZO5CuPDhU6zUyhE1jA0SDTjv1XDMCkNoQ_0nH82poGYOaqA@mail.gmail.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
 <20120202134907.GA3015@richard-laptop>
 <CAOMZO5CuPDhU6zUyhE1jA0SDTjv1XDMCkNoQ_0nH82poGYOaqA@mail.gmail.com>
Message-ID: <20120202144116.GA3278@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 12:15:52PM -0200, Fabio Estevam wrote:
> On 2/2/12, Richard Zhao <richard.zhao@linaro.org> wrote:
> 
> >> Without imx-sgtl5000.c in place, this patch only introduces dead code
> >> at the moment.
> > Each patch make sense too without sgtl5000.
> 
> Well, as this patch goal is to provide audio support to mx6sabrelite,
> we need imx-sgtl5000 in place to test it, right?
My goal seem less important here. You see I'm adding more and more things
into the patch series, which is out of my goal. The maintainers only
consider right patch go to right git.
>  How can we know that
> don't get a kernel oops or something?
patch pass building is possible go to upstream too.
> 
> Regards,
> 
> Fabio Estevam
