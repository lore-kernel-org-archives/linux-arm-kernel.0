From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 2 Mar 2015 14:16:04 +0000
Subject: [PATCH V4 0/6] RCU get_user_pages_fast and __get_user_pages_fast
In-Reply-To: <20150227132000.GD9011@leverpostej>
References: <1411740233-28038-1-git-send-email-steve.capper@linaro.org>
 <54F06636.6080905@redhat.com> <20150227132000.GD9011@leverpostej>
Message-ID: <20150302141604.GB16779@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Head's up: these patches are currently implicated in a rare-to-trigger
> > hang that we are seeing on an internal kernel. An extensive effort is
> > underway to confirm whether these are the cause. Will followup.
> 
> I'm currently investigating an intermittent memory corruption issue in
> v4.0-rc1 I'm able to trigger on Seattle with 4K pages and 48-bit VA,
> which may or may not be related. Sometimes it results in a hang (when
> the vectors get corrupted and the CPUs get caught in a recursive
> exception loop).

FWIW my issue appears to be a bug in the old firmware I'm running.
Sorry for the noise!

Mark.
