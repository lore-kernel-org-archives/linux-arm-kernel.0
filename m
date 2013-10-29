From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 29 Oct 2013 20:01:46 -0200
Subject: [PATCH v3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131028210346.GA11985@kroah.com>
References: <1382992009-19407-1-git-send-email-festevam@gmail.com>
 <20131028210346.GA11985@kroah.com>
Message-ID: <CAOMZO5AX+uh0sT7FHJZBP_ufKznkuFn7jNCB__vrwpcMrqY36w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Mon, Oct 28, 2013 at 7:03 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Oct 28, 2013 at 06:26:49PM -0200, Fabio Estevam wrote:
>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> This is based on the initial work done by Sascha Hauer and Tony Prisk.
>
> What is "this"?

Ok, I will improve the commit log.

> And why is new support being added to this driver instead of working to
> get it out of staging?

Philipp Zabel mentioned that he will submit the imx-drm driver out of staging:
http://www.spinics.net/lists/dri-devel/msg46784.html

> I thought we went through this already...

My understading from your reply at:
http://www.spinics.net/lists/arm-kernel/msg280395.html

,was that the imx-hdmi driver could be moved out of staging (actually
it is not even in staging yet), when it becomes in good shape.

As we had so many issues with the previous imx-hdmi patch version, I
thought it was better to still send v3 to staging so that we could go
through more reviews/testing. Please let me know if I should do it
differently for v4.

Thanks,

Fabio Estevam
