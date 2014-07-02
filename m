From: ezequiel@vanguardiasur.com.ar (Ezequiel =?iso-8859-1?Q?Garc=EDa?=)
Date: Wed, 2 Jul 2014 17:38:58 -0300
Subject: [PATCH/RESEND 0/9] drm: tilcdc driver fixes
In-Reply-To: <CAPM=9tzQR446Xc2xnrSOGa+VetO44KskMFrkPqbatwsmv1dHXQ@mail.gmail.com>
References: <1402110128-30471-1-git-send-email-guido@vanguardiasur.com.ar>
 <1403014631-18072-1-git-send-email-guido@vanguardiasur.com.ar>
 <53ADEB73.8090301@ti.com> <20140701233958.GA31549@fox>
 <53B36EF1.8060200@ti.com>
 <CAPM=9tzQR446Xc2xnrSOGa+VetO44KskMFrkPqbatwsmv1dHXQ@mail.gmail.com>
Message-ID: <20140702203858.GA9576@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02 Jul 02:08 PM, Dave Airlie wrote:
> On 2 July 2014 12:31, Darren Etheridge <detheridge@ti.com> wrote:
> > On 07/01/2014 06:39 PM, Guido Mart?nez wrote:
> >>
> >> On Fri, Jun 27, 2014 at 05:08:51PM -0500, Darren Etheridge wrote:
> >>>
> >>> [snip]
> >>>
> >>> Otherwise I think this is a good and useful patch series.
> >>
> >> It that a Tested-by tag? :)
> >
> >
> > Sure - I would prefer that the WARN_ON was silenced when the tilcdc module
> > is removed, but the series adds improvements over what is there now.  I have
> > tested it across a few variants of AM335x boards and attached display
> > hardware in both module form and built-in to the kernel, therefore:
> >
> > Tested-by: Darren Etheridge <detheridge@ti.com>
> 
> Has someone gathered that tags and put these in a git tree by any chance?
> 

I don't think anyone has. Is that a problem?

If you need a pull request with these, I can prepare something in bitbucket.
Would that work you?
-- 
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
