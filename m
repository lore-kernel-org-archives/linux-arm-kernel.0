From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 May 2018 17:54:42 -0700
Subject: [PATCH 07/11] driver core: Respect all error codes from
 dev_pm_domain_attach()
In-Reply-To: <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
References: <1524732790-2234-1-git-send-email-ulf.hansson@linaro.org>
 <1524732790-2234-8-git-send-email-ulf.hansson@linaro.org>
 <20180514151907.GK98604@atomide.com>
 <CAPDyKFqY5u3=db7-Xd9JXWo228PSNbH7-m-QNfSY9z8Z3p8t8A@mail.gmail.com>
Message-ID: <20180515005442.GN98604@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [180514 18:59]:
> On 14 May 2018 at 17:19, Tony Lindgren <tony@atomide.com> wrote:
> > Reverting for 8c123c14bbba ("driver core: Respect all error codes from
> > dev_pm_domain_attach()") fixes the issue for me.
> >
> > Sounds like something is missing, any ideas?
> 
> This should solve the problem:
> 
> https://patchwork.kernel.org/patch/10398597/

Thanks yeah that fixes it for me too.

Regards,

Tony
