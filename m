From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 9 Jan 2014 20:21:12 +0800
Subject: kexec/kdump for arm64
In-Reply-To: <1380566460.9509.31.camel@smoke>
References: <1380566460.9509.31.camel@smoke>
Message-ID: <CACVXFVOJhPTQm_0bF-gK63=AeAjfA2Qsm36qVoRqAaxcojmjeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Oct 1, 2013 at 2:41 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi All,
>
> Just for anyone who might be interested, I've started to do
> some work on kexec and kdump support for arm64.  This work
> is being done within Linaro, so is tracked by their Jira
> system:
>
>   https://cards.linaro.org/browse/CARD-563
>
> I have these two git repos with my work-in-progress patches:
>
>   https://git.linaro.org/gitweb?p=people/geoff/kexec-tools.git
>
>   https://git.linaro.org/gitweb?p=people/geoff/linux-kexec.git
>
> As of now, I'm just trying to get the pieces in place for a
> basic kexec reboot.  Kdump and advanced features will come
> later.  Comments or suggestions welcome.

Cool!

I am a bit interested in kexec on arm64, and could you share
current status of kexec on arm64? and can I use it inside kvm guest
to restart a new kernel?


Thanks,
-- 
Ming Lei
