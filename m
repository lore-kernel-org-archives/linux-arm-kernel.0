From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Apr 2013 10:17:44 +0100
Subject: [PATCH 07/32] ARM: ux500: Supply address location names for the
 DMA40 DMA controller
In-Reply-To: <CACRpkdbCMjC22WbgE_-Co-hvT704n696Ox8t_6_d2aoxmZyybA@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-8-git-send-email-lee.jones@linaro.org>
 <CACRpkdbCMjC22WbgE_-Co-hvT704n696Ox8t_6_d2aoxmZyybA@mail.gmail.com>
Message-ID: <20130425091744.GF4623@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Linus Walleij wrote:

> On Thu, Apr 18, 2013 at 12:11 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > The DMA40 controller uses two sets of base addresses. In order to have
> > them automatically setup as resources by the Open Format framework we
> > have to set names for them. The names have to be the same as the ones
> > used to fetch them back out of the resource structure.
> >
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> This is OK with Arnds suggested changed, but I want the patch
> split off from this series and put into a device-tree-specific patch
> series so I can apply this to a branch where I try to keep
> all patches to the device tree files. (ux500-devicetree).

Do you want to take this one separately?

Feel free and I'll remove it from this set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
