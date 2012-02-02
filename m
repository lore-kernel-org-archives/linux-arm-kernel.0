From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 2 Feb 2012 12:15:52 -0200
Subject: [PATCH v2 4/9] ARM: dts: imx6q-sabrelite: add sgtl5000 audio codec
In-Reply-To: <20120202134907.GA3015@richard-laptop>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-5-git-send-email-richard.zhao@linaro.org>
 <CAOMZO5CxZgcO1JUZiFFJzWwLao1g7Y1_VNbsuiJOW+PH2B+FNQ@mail.gmail.com>
 <20120202134907.GA3015@richard-laptop>
Message-ID: <CAOMZO5CuPDhU6zUyhE1jA0SDTjv1XDMCkNoQ_0nH82poGYOaqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/2/12, Richard Zhao <richard.zhao@linaro.org> wrote:

>> Without imx-sgtl5000.c in place, this patch only introduces dead code
>> at the moment.
> Each patch make sense too without sgtl5000.

Well, as this patch goal is to provide audio support to mx6sabrelite,
we need imx-sgtl5000 in place to test it, right? How can we know that
don't get a kernel oops or something?

Regards,

Fabio Estevam
