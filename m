From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Oct 2016 07:42:32 -0300
Subject: [PATCH v2 1/2] clk: imx: fix integer overflow in AV PLL round rate
In-Reply-To: <20161011095852.GB8477@lime>
References: <cover.1476092427.git.emil@limesaudio.com>
 <4e8696869cc82443825a590966bbd3a265befdfa.1476092427.git.emil@limesaudio.com>
 <CAOMZO5C56tiXjBArgqZuMdu8_MB6Gq3=xWX65WNvQv+=r6VjGQ@mail.gmail.com>
 <20161011095852.GB8477@lime>
Message-ID: <CAOMZO5B2EPcMumHjM7PkBVZxjOR05qJ+ByOc+EeEz43-p1v4rQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 6:58 AM, Emil Lundmark <emil@limesaudio.com> wrote:

>> Another hint: ./scripts/get_maintainer.pl  drivers/clk/imx/clk-pllv3.c
>> gives you some suggestions on people and lists to add to Cc.
>
> I did that, but read somewhere that you should send it to the maintainers
> and CC the appropriate list. Should I also send it to reviewers?

It would be nice to send to reviewers as well.

>
> Since this patch series only affects i.MX, I chose to not include the
> people from the common clock framework. Was that wrong?

Yes, please include the clock folks and list as well.

Thanks
