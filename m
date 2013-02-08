From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 8 Feb 2013 08:31:21 +0000
Subject: [GIT PULL] ux500 DT related fixes and platform enhancements
In-Reply-To: <CACRpkdaTajxS6YbjyyGPQ=qWiAkLaPySU6WncQ2E8HoAtGXqjA@mail.gmail.com>
References: <20130131115552.GG5301@gmail.com> <20130206135911.GB7519@gmail.com>
 <CAOesGMiJTcjdEJzSDkpdV-ZCqN24uVmfjM-HOt+ojErS=98TmQ@mail.gmail.com>
 <CAF2Aj3gaFtPs7gLd3snzVr1a8Px5A_RN1vz=M+U_LZ3MBpyqqw@mail.gmail.com>
 <CACRpkdaTajxS6YbjyyGPQ=qWiAkLaPySU6WncQ2E8HoAtGXqjA@mail.gmail.com>
Message-ID: <20130208083121.GG7519@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 07 Feb 2013, Linus Walleij wrote:

> On Thu, Feb 7, 2013 at 10:24 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > I can do that. The reason I was submitting myself was due to the massive
> > amount of ux500 DT patches I was pushing. Now that's stopped, I'm happy for
> > Linus to handle it all.
> 
> OK so what about I pull this branch into my ux500 git and
> call it a devicetree branch, and then we can optionally
> merge a few of those ARM: ux500: * patches that
> was sent for the regulator stuff on top of that as well?

There are two reasons why I don't like that idea: 1) As Olof pointed
out, a lot of these patches aren't actually DT related, and 2) I
really want all of the regulator stuff to stay together. Each of the
changes in the platform code are directly dependent on the ones
happening in the regulator driver, and visa versa. It would be best if
they continued to be taken though Marks tree.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
