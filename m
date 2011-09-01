From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 1 Sep 2011 14:33:21 +0530
Subject: [PATCH 4/6] DMA: PL330: Add device tree support
In-Reply-To: <4E5E5B73.20603@gmail.com>
References: <1314348014-2481-1-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-2-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-3-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-4-git-send-email-thomas.abraham@linaro.org>
	<1314348014-2481-5-git-send-email-thomas.abraham@linaro.org>
	<4E579C9B.7030807@gmail.com>
	<CAJuYYwR5GqqKjbMngQqorLuka4XN0jin5s6O66orTtSQg5eKRw@mail.gmail.com>
	<4E5CE37E.1050104@gmail.com>
	<CAJuYYwT5HGy9b06AyrLJv5hFCFf_YRA4md9N=m+cwcJNTqRDWg@mail.gmail.com>
	<4E5E2E36.1070006@gmail.com>
	<CAJuYYwQ17MPD=hTYUxES5touFfd73W1unbtWfu_XqPR48t3P0w@mail.gmail.com>
	<4E5E5B73.20603@gmail.com>
Message-ID: <CAJuYYwS5ish3okCNfseF_LhWkc2CPmAJMqNkDsdBKQxmwhndKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 31 August 2011 21:34, Rob Herring <robherring2@gmail.com> wrote:
> Thomas,

[...]

>
> As it says in Documentation/devicetree/bindings/arm/primecell.txt, you
> should have "arm,primecell" and a value for the specific peripheral. It
> should be in order of most specific to least specific.
>
> What Linux uses currently from the binding is a bit irrelevant. The
> binding is supposed to be future proof. An OS could choose to not use
> the primecell ID at all and only match with compatible string.

Thanks for pointing this out. "arm,pl330" has been added as another
mandatory compatible string for the pl330 device node.

Regards,
Thomas.

>
> Rob
>

[...]
