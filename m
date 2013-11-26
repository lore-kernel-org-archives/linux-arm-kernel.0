From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 26 Nov 2013 13:13:15 +0100
Subject: [PATCH] clk: exynos: Fix typos in DT bindings documentation
In-Reply-To: <CAK9yfHxL8DnN8BE94-L3_MK+dBO0exEq7YAamXRHQ7Abo3jYyQ@mail.gmail.com>
References: <1384775172-3373-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1566145.0GyXC9vG8j@avalon>
 <CAK9yfHxL8DnN8BE94-L3_MK+dBO0exEq7YAamXRHQ7Abo3jYyQ@mail.gmail.com>
Message-ID: <1538452.UuDUTCGYER@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 of November 2013 11:23:49 Sachin Kamat wrote:
> +CC Mike and removed a few from the list.
> 
> Hi Laurent,
> 
> On 26 November 2013 05:52, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > Hi Sachin,
> >
> > On Monday 18 November 2013 17:17:39 Sachin Kamat wrote:
> >> On 18 November 2013 17:16, Laurent Pinchart wrote:
> >> > s/comptible/compatible/
> >> >
> >> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> Good catch.
> >>
> >> Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>
> >
> > Have you queued up the patch for v3.14 ?
> 
> No, I haven't. This should either go through DT tree or else Tomasz Figa can
> pick this up and send it to Mike as per the new workflow for 3.14.
> 
> 

Well, since this is purely a fix for the documentation, without any
dependencies on clk tree, I see no reason to send it in any other way than
through DT tree directly.

As for clk-samsung tree, I'm currently in process of preparing a tree on
kernel.org so I should start picking up Samsung clock patches soon.

By the way, the patch adding me to MAINTAINERS file has not been merged
yet. Mike, are there any issues?

Best regards,
Tomasz
