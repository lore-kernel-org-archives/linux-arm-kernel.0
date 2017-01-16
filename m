From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jan 2017 11:59:40 +0000
Subject: [PATCH v18 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
In-Reply-To: <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
References: <20161208173319.6618-1-fu.wei@linaro.org>
 <20170113192920.GF2472@leverpostej>
 <CADyBb7vF0v2DwXA8fNUOTQcqriJK1Hp57_G8DKi0WO9FnvrB5w@mail.gmail.com>
 <CADyBb7ugz_YpxKQUsJbF1vdjm_Nzyh2mH8TZMPqj1cSHGSPCFw@mail.gmail.com>
Message-ID: <20170116115940.GC5908@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 08:54:46AM +0800, Fu Wei wrote:
> On 14 January 2017 at 19:34, Fu Wei <fu.wei@linaro.org> wrote:
> > On 14 January 2017 at 03:29, Mark Rutland <mark.rutland@arm.com> wrote:

> >> Once v4.10-rc4 comes out this weekend, could you please rebase and
> >> repost this?
> >
> > Yes, of course.
> >
> > I have rebased v19 to the latest v4.10-rc3-e96f8f1, it dosen't need
> > any modification.
> > I will rebase it every day, and will repost it if it need any  modification.
> >
> > But for now, V19 works well with the master branch of upstream kernel.
> > Do I need to re-post it even if it doesn't need any improvement or
> > modification? :-)
> 
> I just fetched the latest mainline kernel, and rebase v19 on the top
> of 4.10-rc4.
> I have double checked it, V19 works well with  4.10-rc4.
> For rebasing,  it doesn't need any modification.

Ok. Assuming that the patches apply cleanly atop of v4.10-rc4, I will
look over this shortly.

Thanks for checking that!

Mark.
