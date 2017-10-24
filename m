From: kim.phillips@arm.com (Kim Phillips)
Date: Tue, 24 Oct 2017 03:42:51 -0500
Subject: [PATCH v5 6/7] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20171002183524.ab23b255b6d03331bb36f75a@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-7-git-send-email-will.deacon@arm.com>
 <20170929171940.2aa33d00463b1e9c987aea15@arm.com>
 <20171002141405.GC12847@arm.com> <20171002164930.GB2121@redhat.com>
 <20171002183524.ab23b255b6d03331bb36f75a@arm.com>
Message-ID: <20171024034251.81e01386b8074683a40d31e1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2 Oct 2017 18:35:24 -0500
Kim Phillips <kim.phillips@arm.com> wrote:

> On Mon, 2 Oct 2017 13:49:30 -0300
> Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
> > I'm all for more informative messages, and if you guys agree on how to
> > provide the info in a way that combined with logic in evsel.c, I'd say
> > do what Will suggested, post a patch series and include usage examples,
> > before and after.
> 
> I'll figure out how to get the PMU in evsel.c's strerror fn, and give it
> another shot.  I don't think it'll be a big problem for the SPE driver
> itself, it's just some of the other drivers have long lists of reasons
> to return -EXXXX, and I don't think evsel.c's strerror fn should be
> able to handle all that.

See this example for the arm-ccn driver:

http://lists.infradead.org/pipermail/linux-arm-kernel/2017-October/538924.html

Please follow up on that thread.

Thanks,

Kim
