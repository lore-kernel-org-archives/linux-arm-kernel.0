From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Tue, 8 Jan 2013 22:59:17 +0530
Subject: [PATCH] ARM: dts: correct the dw-mshc timing properties as per
 binding
In-Reply-To: <CAD=FV=XUpLwZCn=bpShFqiPBzFBaAbWYn5-+-_OuTqC55sKi3Q@mail.gmail.com>
References: <1357557585-30257-1-git-send-email-alim.akhtar@samsung.com>
 <CAD=FV=XUpLwZCn=bpShFqiPBzFBaAbWYn5-+-_OuTqC55sKi3Q@mail.gmail.com>
Message-ID: <CAGOxZ52vsbmmmKBLZjvy2wZBDGeVTP5rwJ5Oc00oYUo2ztA2Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On Tue, Jan 8, 2013 at 12:34 AM, Doug Anderson <dianders@chromium.org> wrote:
>
> Alim,
>
> On Mon, Jan 7, 2013 at 3:19 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> > As per the current exynos-dw-mshc bindings, dw-mshc-sdr-timing and
> > dw-mshc-ddr-timing properties are having only two cells, these properties
> > are wrongly set for exynos5250 based cros5250 and smdk5250 platfroms. This patch
> > corrects above timing propreties for above platfroms
>
> Thanks for catching this.  Given that this just removes a number from
> the dts file that isn't read by the code, I don't expect any
> functional change and I don't see any.
>
> I also double-checked usage and compared to the current Chrome OS
> tree.  The third number (that you removed) is already correctly
> specified in the dts as "samsung,dw-mshc-ciu-div".  :)

 Yes, no functional changes as the removed number is passed using
dw-mshc-ciu-div  property now as mentioned by you.
>
>
>
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Doug Anderson <dianders@chromium.org>
Thanks!!!

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
